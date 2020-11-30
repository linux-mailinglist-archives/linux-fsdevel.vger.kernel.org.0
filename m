Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E12C2C93E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 01:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388378AbgLAA1P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 19:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388331AbgLAA1P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:27:15 -0500
X-Greylist: delayed 3185 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Nov 2020 16:26:15 PST
Received: from rcpt-mqugw.biglobe.ne.jp (rcpt-mqugw.biglobe.ne.jp [IPv6:2001:260:450:ad::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEA5C0617A7
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 16:26:15 -0800 (PST)
Received: from rcpt-expgw.biglobe.ne.jp
        by rcpt-mqugw.biglobe.ne.jp (hngd/4713110516) with ESMTP id 0AUNX8Wr003545
        for <linux-fsdevel@vger.kernel.org>; Tue, 1 Dec 2020 08:33:08 +0900
Received: from vc-gw.biglobe.ne.jp
        by rcpt-expgw.biglobe.ne.jp (hngd/4514161018) with ESMTP id 0AUNX5m9005870;
        Tue, 1 Dec 2020 08:33:05 +0900
Received: from smtp-gw.biglobe.ne.jp ([192.168.154.157])
        by vc-gw.biglobe.ne.jp (shby/1011270619) with ESMTP id 0AUNX5Fv018490;
        Tue, 1 Dec 2020 08:33:05 +0900
X-Biglobe-Sender: <takimoto-j@kba.biglobe.ne.jp>
Received: from tamac1.yz.yamagata-u.ac.jp ([133.24.84.20]) by smtp-gw.biglobe.ne.jp
        id INhCC0A89941; Tue, 01 Dec 2020 08:33:05 +0900 (JST)
From:   Jun T <takimoto-j@kba.biglobe.ne.jp>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: PROBLEM: can't write to a file if RLIMIT_FSIZE is too large
Message-Id: <8F9EB913-3AC3-4D89-9DA3-427029F6D211@kba.biglobe.ne.jp>
Date:   Tue, 1 Dec 2020 08:33:05 +0900
Cc:     linux-fsdevel@vger.kernel.org
To:     Alexander Viro <viro@zeniv.linux.org.uk>
X-Mailer: Apple Mail (2.3445.104.17)
X-Biglobe-Spnum: 12999
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(If this is not a correct way of reporting bug, let me know.)

[Description of the problem (cosmetic)]
If RLIMIT_FSIZE is set in the range
    2**63 <= lim < RLIM_INFINITY = 2**64 - 1
then the process can't write to a file.

[Possible cause of the problem]
I guess the problem is in the function generic_write_check_limits().
In fs/read_write.c, at line 1607:
    loff_t limit = rlimit(RLIMIT_FSIZE);
loff_t is signed 64 bit, and the variable 'limit' gets negative value.
But just replacing loff_t by 'unsigned long' (rlmin_t) may not work?
(due to signed --> unsigned conversion, for example).
Another possibility would be to lower RLIM_INFINITY to 2**63 - 1.

[How to reproduce]
Compile and run the following C-code:

#include <sys/resource.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>

int main() {
	struct rlimit rlim;
	int fd;

	/* set RLIMIT_FSIZE to 2**63 */
	rlim.rlim_cur = rlim.rlim_max = (rlim_t)1 << 63;
	if(setrlimit(RLIMIT_FSIZE, &rlim) < 0) {
		perror("setrlimit"); return 1;
	}
	if(getrlimit(RLIMIT_FSIZE, &rlim) < 0) {
		perror("getrlimit"); return 1;
	}
	printf("rlim_cur=%#lx\n", rlim.rlim_cur);

	if((fd = creat("tmp.txt", 0600)) < 0) {
		perror("creat"); return 1;
	}
	if(write(fd, "A", 1) < 0) {	/* coredump here */
		perror("write"); return 1;
	}
	close(fd);
	return 0;
}

$ ./a.out
rlim_cur=0x8000000000000000
[1]    185552 file size limit exceeded (core dumped)  ./a.out

------------------------------------------------
Jun-ichi Takimoto <takimoto-j@kba.biglobe.ne.jp>
