Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC36638D09
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 16:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbfFGOaR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 10:30:17 -0400
Received: from helmsgmaster01.f-secure.com ([193.110.108.20]:48646 "EHLO
        helmsgmaster01.f-secure.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729080AbfFGOaQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:30:16 -0400
X-Greylist: delayed 2519 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jun 2019 10:30:16 EDT
Received: from pps.filterd (helmsgmaster01.f-secure.com [127.0.0.1])
        by helmsgmaster01.f-secure.com (8.16.0.27/8.16.0.27) with SMTP id x57Depgx029706
        for <linux-fsdevel@vger.kernel.org>; Fri, 7 Jun 2019 16:48:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=f-secure.com; h=from : to : subject
 : date : message-id : mime-version : content-type; s=msg2048;
 bh=5xOdqZA/v0YeNkyL6dtqTzVgG1d7jdryW/lQh/DF5kw=;
 b=XOgbcUtbR08+rQkh23g0vaOpgp+6p0VtcshWz38KMzb3CS2XpcLhIt/SoSRJO7bz9rZ7
 C1YYptGGe2P7VNsPkdnE6Y9aCUtNx23ZKulh53kL749Y3snBGnn9SEz+LlZYSUT+aGC3
 XNeDiSZ9OOc8/xargZnb0FXyCHR/YBIOd5fUa86Sw8X0pauNY+Wg/59hdi2BZESnXyZE
 6VNwoV0jwE875U0JHIVHiTjNFu0uSUHZTyUY4JgYPgw+m4VVvZHdiuLSDgKLBJQLHM9u
 qjiRWtGsuU5BUTg1MyO8EQQMvZP4sqo0v9wuqtr5Ou3j08LJWr1ebCp3oqfL2onpPB1e gg== 
Received: from helex02.fi.f-secure.com ([10.190.48.73])
        by helmsgmaster01.f-secure.com with ESMTP id 2svtpmm16b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jun 2019 16:48:16 +0300
Received: from drapion.f-secure.com (10.128.132.96) by helex01.FI.F-Secure.com
 (10.190.48.70) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 16:48:15 +0300
From:   Marko Rauhamaa <marko.rauhamaa@f-secure.com>
To:     <linux-fsdevel@vger.kernel.org>
Subject: fanotify and pidfd?
Date:   Fri, 7 Jun 2019 16:48:15 +0300
Message-ID: <87zhmt7bhc.fsf@drapion.f-secure.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


As it stands, fanotify reports the process ID of the file that is being
operated on:

           struct fanotify_event_metadata {
               __u32 event_len;
               __u8 vers;
               __u8 reserved;
               __u16 metadata_len;
               __aligned_u64 mask;
               __s32 fd;
               __s32 pid;
           };

One nasty problem with this is that the process often is long gone by
the time the notification arrives.

Would it be possible to amend this format with:

               __s32 pidfd;

It would hold the pid still for the duration of notification processing
and allow for the fanotify monitor to safely use the pid field to
inspect /proc/<pid>.

And the possibility of sending signals to the monitored process might
come in handy as well.

Thinking about this a bit more, could the fd field take on the dual role
of allowing you to read the file in question as well as acting as a
pidfd?


Marko
