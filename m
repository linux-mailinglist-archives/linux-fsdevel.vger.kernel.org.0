Return-Path: <linux-fsdevel+bounces-76920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM18F/rii2kVcgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 03:01:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5011209D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 03:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 590C1301BDF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 02:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49E22EC0A7;
	Wed, 11 Feb 2026 02:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jLiAv0Op"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96AC2ECEA5;
	Wed, 11 Feb 2026 02:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770775286; cv=none; b=ma0yw1yCy1elbD+1C6KOCIXmJbRcfyRYbQel3jFFCcHPhRp3LIZkfDFfKBiJyX4BDG+2hnhqR89MYDWgUHRKPSIW1x0MkCvPjSJ45CjW3TfgX8dzBwLKWpRjbbC8BZjDc/UsuJnHlZIDorAIE68uiy/DnAphXfDr7ThyRb/MUrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770775286; c=relaxed/simple;
	bh=uGRX7zvdqkBXKoNCyg2e3snv/ogf/TtjZBlU8rTNBNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lB9LAifuktkpcEbRiUqFzu4hqosgD5FcCXIq+MXGRlCo94dUt5uyYjxxifBut81lcemu4fZNDV2lQPHmU91UxKZ+bcfmQEcH+qIL3w6B/sUxGBDnVFXs7fNxGzFjSPoHrjJLbx5TeW001lchpyU5iUlbloGo/1IPOAm6paHdU3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jLiAv0Op; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9USXWQPjmAS8PG0xMgBazXt1fL5bxi/dxEKLW+WFTME=; b=jLiAv0OpetCFO1blM8aIb3GsC8
	GZWanvAaRn/gNViWMSXLOye86NEBuVYi77hXWrzmsWDdoDLBI6yf/CudoJep9NpC0DznCG0mz6fJJ
	vKgKvQqnsj9ZQk8NMzfPud3/dRVdu9E47tjhYryb+1GHUC8fV3fe6mG0heF5Pdy3vVThU0MTUh/CY
	vbZejJfw/B3XeSz0ETyYDdAFbFGuacJDpB1+4tBDPbzFWBpJLxTZy9IKM7z+HQp580s4XHVtTGSXA
	AHYwuPUisCxyH342S7kmygtJPLTFRUnAN8tNCPpSAffwHLkSL4vnxZqbeff+IBr3x7Od0odn8gERR
	bVNYjmsA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vpzZj-0000000H7yg-2Pzg;
	Wed, 11 Feb 2026 02:03:31 +0000
Date: Wed, 11 Feb 2026 02:03:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "jack@suse.cz" <jack@suse.cz>, "frank.li@vivo.com" <frank.li@vivo.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
	"shardulsb08@gmail.com" <shardulsb08@gmail.com>,
	"janak@mpiricsoftware.com" <janak@mpiricsoftware.com>,
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com" <syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2] hfsplus: fix s_fs_info leak on mount setup failure
Message-ID: <20260211020331.GJ3183987@ZenIV>
References: <20260201131229.4009115-1-shardul.b@mpiricsoftware.com>
 <cace4df975e1ae6e31af0103efcbca9cdb8b8350.camel@ibm.com>
 <20260203043806.GF3183987@ZenIV>
 <b9374ab2503627e0dd6f62a29ab5dcde9fc0354f.camel@ibm.com>
 <20260204173029.GL3183987@ZenIV>
 <20260204174047.GM3183987@ZenIV>
 <20260204175257.GN3183987@ZenIV>
 <20260204182557.GO3183987@ZenIV>
 <95e3ab710185fc18d820a64e6cb98e652de9694b.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95e3ab710185fc18d820a64e6cb98e652de9694b.camel@ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76920-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vivo.com,kernel.org,vger.kernel.org,dubeyko.com,mpiricsoftware.com,gmail.com,physik.fu-berlin.de,syzkaller.appspotmail.com];
	TAGGED_RCPT(0.00)[linux-fsdevel,99f6ed51479b86ac4c41];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.org.uk:dkim]
X-Rspamd-Queue-Id: EE5011209D2
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 10:22:20PM +0000, Viacheslav Dubeyko wrote:

> I did run the xfstests for HFS+ with viro/vfs.git #untested.hfsplus. Everything
> looks good, I don't see any new issues. Currently, around 29 test-cases fail for
> HFS+. I see the same number of failures with applied patchset.
> 
> The code looks good. And I am ready to take the patchset into HFS/HFS+ tree.
> Would you like to send the pathset for nls.h modification discussion?

FWIW, I wonder what the hell is that code doing:
        err = -EINVAL;
        if (!sbi->nls) {
                /* try utf8 first, as this is the old default behaviour */
                sbi->nls = load_nls("utf8");
                if (!sbi->nls)
                        sbi->nls = load_nls_default();
        }
 
        /* temporarily use utf8 to correctly find the hidden dir below */
        nls = sbi->nls;   
        sbi->nls = load_nls("utf8");
        if (!sbi->nls) {
                pr_err("unable to load nls for utf8\n");
                goto out_unload_nls;
        }

If load_nls("utf8") fails on the first call, I don't see how the second one
might succeed.  What's the intended behaviour here?

What that code actually does is
	* if UTF8 isn't loadable, fail hard, no matter what
	* if it is loadable, use it for the duration of fill_super,
then if we had something configured, switch back to that, otherwise
stay with UTF8.

