Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77E29CF079
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 03:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfJHB02 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 21:26:28 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48962 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729327AbfJHB02 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 21:26:28 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHeGc-00054z-D2; Tue, 08 Oct 2019 01:26:22 +0000
Date:   Tue, 8 Oct 2019 02:26:22 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hugh Dickins <hughd@google.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: mount on tmpfs failing to parse context option
Message-ID: <20191008012622.GP26530@ZenIV.linux.org.uk>
References: <d5b67332-57b7-c19a-0462-f84d07ef1a16@redhat.com>
 <d7f83334-d731-b892-ee49-1065d64a4887@redhat.com>
 <alpine.LSU.2.11.1910071655060.4431@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1910071655060.4431@eggly.anvils>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 07, 2019 at 05:50:31PM -0700, Hugh Dickins wrote:

[sorry for being MIA - had been sick through the last week, just digging
myself from under piles of mail; my apologies]

> (tmpfs, very tiresomely, supports a NUMA "mpol" mount option which can
> have commas in it e.g "mpol=bind:0,2": which makes all its comma parsing
> awkward.  I assume that where the new mount API commits bend over to
> accommodate that peculiarity, they end up mishandling the comma in
> the context string above.)

	Dumber than that, I'm afraid.  mpol is the reason for having
->parse_monolithic() in the first place, all right, but the problem is
simply the lack of security_sb_eat_lsm_opts() call in it.

	Could you check if the following fixes that one?

diff --git a/mm/shmem.c b/mm/shmem.c
index 0f7fd4a85db6..8dcc8d04cbaf 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3482,6 +3482,12 @@ static int shmem_parse_options(struct fs_context *fc, void *data)
 {
 	char *options = data;
 
+	if (options) {
+		int err = security_sb_eat_lsm_opts(options, &fc->security);
+		if (err)
+			return err;
+	}
+
 	while (options != NULL) {
 		char *this_char = options;
 		for (;;) {
