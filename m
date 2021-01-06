Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFB12EC659
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 23:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbhAFWri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 17:47:38 -0500
Received: from venus.catern.com ([68.183.49.163]:47294 "EHLO venus.catern.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbhAFWri (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 17:47:38 -0500
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jan 2021 17:47:37 EST
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=98.7.229.235; helo=localhost; envelope-from=sbaugh@catern.com; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=catern.com; s=mail;
        t=1609972627; bh=GhGqfhrOmk85bE9brf63v61AQzlMYBaNZ+f/18AJtj8=;
        h=From:To:Cc:Subject:Date;
        b=P1/agWQRlSIpE5EI66HiAfbnB5qN+6p+vw2ZXK6sWeNXMo6AH7glAMEHZeAjQhLYe
         cjhe72+bFPscefg32PaxAAbEoI653W0ze+HpyKGNo/joAaLJp1CKBwpUfwLOakPTpj
         +V+EqdWbppCdEoWBFTTajAzUOkosP3EhdtjBLOeg=
Received: from localhost (cpe-98-7-229-235.nyc.res.rr.com [98.7.229.235])
        by venus.catern.com (Postfix) with ESMTPSA id A1C932E10C4;
        Wed,  6 Jan 2021 22:37:07 +0000 (UTC)
From:   Spencer Baugh <sbaugh@catern.com>
To:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     inux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: FUSE no longer allows empty string for "source" with new mount API
Date:   Wed, 06 Jan 2021 17:37:00 -0500
Message-ID: <871rexvgj7.fsf@catern.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi,

Calling mount(2) and passing an empty string for the "source" parameter
when mounting a FUSE filesystem used to work.

However, it seems after the migration to the new mount API, passing an
empty string for "source" with mount(2) no longer works, since the new
mount API actually parses the "source" parameter and doesn't allow an
empty string. This breaks users of FUSE which don't go through libfuse,
so it seems like a userspace-visible regression.

I haven't bisected to confirm that it's specifically the new mount API
which is the problem, just seen that it works on some old kernels and
fails on some kernels after

commit c30da2e981a703c6b1d49911511f7ade8dac20be
Author: David Howells <dhowells@redhat.com>
Date:   Mon Mar 25 16:38:31 2019 +0000

    fuse: convert to use the new mount API

so apologies if the culprit turns out to be something else.

I'd try to fix it myself, but I'm not sure how to completely ignore a
parameter with the new mount API - I assume that with the new mount API,
we need to explicitly handle "source", so something like the below
simple patch won't work.

Thanks,
Spencer Baugh

---
1 file changed, 8 deletions(-)
fs/fuse/inode.c | 8 --------

modified   fs/fuse/inode.c
@@ -449,7 +449,6 @@ enum {
 };
 
 static const struct fs_parameter_spec fuse_fs_parameters[] = {
-	fsparam_string	("source",		OPT_SOURCE),
 	fsparam_u32	("fd",			OPT_FD),
 	fsparam_u32oct	("rootmode",		OPT_ROOTMODE),
 	fsparam_u32	("user_id",		OPT_USER_ID),
@@ -473,13 +472,6 @@ static int fuse_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		return opt;
 
 	switch (opt) {
-	case OPT_SOURCE:
-		if (fc->source)
-			return invalfc(fc, "Multiple sources specified");
-		fc->source = param->string;
-		param->string = NULL;
-		break;
-
 	case OPT_SUBTYPE:
 		if (ctx->subtype)
 			return invalfc(fc, "Multiple subtypes specified");

