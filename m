Return-Path: <linux-fsdevel+bounces-74878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCFCKnkTcWlEcgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 18:57:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 219405ADA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 18:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58E06AC7FFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 16:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78D7340295;
	Wed, 21 Jan 2026 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OA/qnDZE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q7FNSLjM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OA/qnDZE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q7FNSLjM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F03033BBD1
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012232; cv=none; b=cOHJ3xZ9oIJ5uj9nYj5hti/n2jLc5++CV8coRbRZMr5oZU9gtufE9GXEckVlVnLzve49eBMPTH5RyMjPmynUsIAE4IgeNL+BneWKGq0/cRjWK630OqwDh3CJzA6eqnoAkautXxC+02h/5Rd794E/vgrk2f/34Tf2LltJs3B7hBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012232; c=relaxed/simple;
	bh=dAXRlYSMcRhAn+i52qai9zardB6VBMXdGcHMpYDAKLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LE4G+YA2IrRD/dou5UwjowxBFwu1XMt7sVo5TiIcoqR44yXHCtdWL0rdEdYu1TMCZ1jKyrKE7j4qSGI9DWE/4827wsO3mXG/8khTMOfHm0LWEbdF+o/BYvjMyeArI7JbNf5S7iQhE+G3Q/v3uqZIGwrLPQmrQi6yufFBNol3d4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OA/qnDZE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q7FNSLjM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OA/qnDZE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q7FNSLjM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 015F25BD38;
	Wed, 21 Jan 2026 16:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769012228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcQ0Wp8QfNhVZW97FfSKJnFS1FN2vdhVTlYCvKPvGUc=;
	b=OA/qnDZE9u8HUqyarSZPIsGvDvhTPJ7oWCbPRqELfV941Zq0EujiWRtM2wR9W9iZNu7Ok5
	KtmXMVtGEyP0yuebdDUisg+e2T09pS3RMw1jCtj/8UCdgWi8R+pLDqDL4FbLAPxSb+N3oA
	AiVIbdrWHWwoj6dKXZ2MhtsLwKZUr4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769012228;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcQ0Wp8QfNhVZW97FfSKJnFS1FN2vdhVTlYCvKPvGUc=;
	b=q7FNSLjMYpXzz2Q5nJGsS6MqvkYvP0axpVUrfV5WKKJIcV9vyD5vaRn4oWOk+5S5QT6yn+
	ii73hLrqGEeipCDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="OA/qnDZE";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=q7FNSLjM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769012228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcQ0Wp8QfNhVZW97FfSKJnFS1FN2vdhVTlYCvKPvGUc=;
	b=OA/qnDZE9u8HUqyarSZPIsGvDvhTPJ7oWCbPRqELfV941Zq0EujiWRtM2wR9W9iZNu7Ok5
	KtmXMVtGEyP0yuebdDUisg+e2T09pS3RMw1jCtj/8UCdgWi8R+pLDqDL4FbLAPxSb+N3oA
	AiVIbdrWHWwoj6dKXZ2MhtsLwKZUr4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769012228;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcQ0Wp8QfNhVZW97FfSKJnFS1FN2vdhVTlYCvKPvGUc=;
	b=q7FNSLjMYpXzz2Q5nJGsS6MqvkYvP0axpVUrfV5WKKJIcV9vyD5vaRn4oWOk+5S5QT6yn+
	ii73hLrqGEeipCDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC6153EA63;
	Wed, 21 Jan 2026 16:17:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bi51MAP8cGkgVwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 21 Jan 2026 16:17:07 +0000
Date: Thu, 22 Jan 2026 03:17:02 +1100
From: David Disseldorp <ddiss@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] initramfs_test: test header fields with 0x hex
 prefix
Message-ID: <20260122031702.5e2e73c8.ddiss@suse.de>
In-Reply-To: <aXDRithD3DsGiXBc@smile.fi.intel.com>
References: <20260120204715.14529-1-ddiss@suse.de>
	<20260120204715.14529-3-ddiss@suse.de>
	<aW__NwDBkzq_bePk@smile.fi.intel.com>
	<20260121201936.0580e4de.ddiss@suse.de>
	<aXDRithD3DsGiXBc@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[suse.de,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74878-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ddiss@suse.de,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 219405ADA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 21 Jan 2026 15:15:54 +0200, Andy Shevchenko wrote:

> On Wed, Jan 21, 2026 at 08:42:05PM +1100, David Disseldorp wrote:
> > On Wed, 21 Jan 2026 00:18:31 +0200, Andy Shevchenko wrote:  
> > > On Wed, Jan 21, 2026 at 07:32:33AM +1100, David Disseldorp wrote:  
> > > > cpio header fields are 8-byte hex strings, but one "interesting"
> > > > side-effect of our historic simple_str[n]toul() use means that a "0x"
> > > > prefixed header field will be successfully processed when coupled
> > > > alongside a 6-byte hex remainder string.    
> > > 
> > > Should mention that this is against specifications.

I've added this and will send as v2.

> > > > Test for this corner case by injecting "0x" prefixes into the uid, gid
> > > > and namesize cpio header fields. Confirm that init_stat() returns
> > > > matching uid and gid values.    
> > > 
> > > This is should be considered as an invalid case and I don't believe
> > > we ever had that bad header somewhere. The specification is clear
> > > that the number has to be filled with '0' to the most significant
> > > byte until all 8 positions are filled.
> > > 
> > > If any test case like this appears it should not be fatal.  
> > 
> > Yes, the test case can easily be changed to expect an unpack_to_rootfs()
> > error (or dropped completely). The purpose is just to ensure that the
> > user visible change is a concious decision rather than an undocumented
> > side effect.  
> 
> Can you say this clearly in the commit message? With that done I will have
> no objections as it seems we all agree with the possible breakage of this
> "feature" (implementation detail).

Sure, I think it'd make sense to put the v2 test patches as 1/2 in your
series such that your subsequent hex2bin() patch modifies the test to
expect error. E.g.

--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -499,8 +499,7 @@ static void __init initramfs_test_hdr_hex(struct kunit *test)
 {
        char *err, *fmt;
        size_t len;
-       struct kstat st0, st1;
-       char fdata[] = "this file data will be unpacked";
+       char fdata[] = "this file data will not be unpacked";
        struct initramfs_test_bufs {
                char cpio_src[(CPIO_HDRLEN + PATH_MAX + 3 + sizeof(fdata)) * 2];
        } *tbufs = kzalloc(sizeof(struct initramfs_test_bufs), GFP_KERNEL);
@@ -528,28 +527,14 @@ static void __init initramfs_test_hdr_hex(struct kunit *test)
        /*
         * override CPIO_HDR_FMT and instead use a format string which places
         * "0x" prefixes on the uid, gid and namesize values.
-        * parse_header()/simple_str[n]toul() accept this.
+        * parse_header()/simple_str[n]toul() accepted this, contrary to the
+        * initramfs specification. hex2bin() now fails.
         */
        fmt = "%s%08x%08x0x%06x0X%06x%08x%08x%08x%08x%08x%08x%08x0x%06x%08x%s";
        len = fill_cpio(c, ARRAY_SIZE(c), fmt, tbufs->cpio_src);
 
        err = unpack_to_rootfs(tbufs->cpio_src, len);
-       KUNIT_EXPECT_NULL(test, err);
-
-       KUNIT_EXPECT_EQ(test, init_stat(c[0].fname, &st0, 0), 0);
-       KUNIT_EXPECT_EQ(test, init_stat(c[1].fname, &st1, 0), 0);
-
-       KUNIT_EXPECT_TRUE(test,
-               uid_eq(st0.uid, make_kuid(current_user_ns(), (uid_t)0x123456)));
-       KUNIT_EXPECT_TRUE(test,
-               gid_eq(st0.gid, make_kgid(current_user_ns(), (gid_t)0x123457)));
-       KUNIT_EXPECT_TRUE(test,
-               uid_eq(st1.uid, make_kuid(current_user_ns(), (uid_t)0x56)));
-       KUNIT_EXPECT_TRUE(test,
-               gid_eq(st1.gid, make_kgid(current_user_ns(), (gid_t)0x57)));
-
-       KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
-       KUNIT_EXPECT_EQ(test, init_rmdir(c[1].fname), 0);
+       KUNIT_EXPECT_NOT_NULL(test, err);

IMO the only thing then missing is proper
hex2bin->parse_header->do_header error propagation, e.g.

--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -193,14 +193,16 @@ static __initdata gid_t gid;
 static __initdata unsigned rdev;
 static __initdata u32 hdr_csum;
 
-static void __init parse_header(char *s)
+static int __init parse_header(char *s)
 {
        __be32 header[13];
        int ret;
 
        ret = hex2bin((u8 *)header, s + 6, sizeof(header));
-       if (ret)
+       if (ret) {
                error("damaged header");
+               return ret;
+       }
 
        ino = be32_to_cpu(header[0]);
        mode = be32_to_cpu(header[1]);
@@ -214,6 +216,7 @@ static void __init parse_header(char *s)
        rdev = new_encode_dev(MKDEV(be32_to_cpu(header[9]), be32_to_cpu(header[10])));
        name_len = be32_to_cpu(header[11]);
        hdr_csum = be32_to_cpu(header[12]);
+       return 0;
 }
 
 /* FSM */
@@ -293,7 +296,8 @@ static int __init do_header(void)
                        error("no cpio magic");
                return 1;
        }
-       parse_header(collected);
+       if (parse_header(collected))
+               return 1;
        next_header = this_header + N_ALIGN(name_len) + body_len;
        next_header = (next_header + 3) & ~3;
        state = SkipIt;


