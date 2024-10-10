Return-Path: <linux-fsdevel+bounces-31640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D18999495
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 23:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26DAA1C22C6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 21:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4491E5034;
	Thu, 10 Oct 2024 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a5JJZfoF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RVWaGtvm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a5JJZfoF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RVWaGtvm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9378F6A;
	Thu, 10 Oct 2024 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728596620; cv=none; b=TIO74AusEzuDDoB9u97YnsFW1JiO6eW4wbildsP1moZyOUAMQQwgodHkuTfwReX4OC/7v1lnVL6hkU1uvbd6O+r5LLMdNxlI2/uu7iD1S8dl+qNfSLJCSiZikQ8L4Mhn5VQw0AqJemI9EVDtugy2YIc+5wLj1FEAUrnb7yiLy50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728596620; c=relaxed/simple;
	bh=Oec2XcEHnRVkA96bUDHw8C1REQbckjcVfS0072SQmrI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=B5L7NnZ0dGNXTkEAEIOy3l2QfLlxrCq7f9sCGyJDlrJeixUq4ckeIAT8mBtf/LJPdWsHk7apwqT8a4uwHKAlmiEMq53r6aHBfWYMGCDRdh84eDOfQ5FHMMt4UeRY+RwTsIgww/A+D1EavEJxbou11IUqnz8Q6LgwkRGNexL9eW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a5JJZfoF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RVWaGtvm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a5JJZfoF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RVWaGtvm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9EE701FE77;
	Thu, 10 Oct 2024 21:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728596616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BLVaQNxwgGS4hs6TdXQIhC+xDJeoNKY0cDCGry5g1U=;
	b=a5JJZfoFKe+RffAGjiKiKDWGT8xkOirsMEpsysJkAqadTXwun3xEaq+O1DDhmCym/ShUAr
	bh6o8s+5amzjhUKHJnUM3MjSWDU96GIHeZ5JirpVokB7w49CHI6ce9E5XSIGInUQDMXvIs
	bKwfMlBCqKX+9eQIEw5/w9q3lx/DeMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728596616;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BLVaQNxwgGS4hs6TdXQIhC+xDJeoNKY0cDCGry5g1U=;
	b=RVWaGtvmGJPTmtqJbLqdObnWbVcu3Y0VGtbW3Wku/80a//iKt2toqNptyvNguHWiO4MuUt
	WI7rq9k5AOyVqwDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728596616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BLVaQNxwgGS4hs6TdXQIhC+xDJeoNKY0cDCGry5g1U=;
	b=a5JJZfoFKe+RffAGjiKiKDWGT8xkOirsMEpsysJkAqadTXwun3xEaq+O1DDhmCym/ShUAr
	bh6o8s+5amzjhUKHJnUM3MjSWDU96GIHeZ5JirpVokB7w49CHI6ce9E5XSIGInUQDMXvIs
	bKwfMlBCqKX+9eQIEw5/w9q3lx/DeMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728596616;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BLVaQNxwgGS4hs6TdXQIhC+xDJeoNKY0cDCGry5g1U=;
	b=RVWaGtvmGJPTmtqJbLqdObnWbVcu3Y0VGtbW3Wku/80a//iKt2toqNptyvNguHWiO4MuUt
	WI7rq9k5AOyVqwDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE73113A6E;
	Thu, 10 Oct 2024 21:43:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IPoSIXZKCGeEZwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 10 Oct 2024 21:43:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Kaixiong Yu" <yukaixiong@huawei.com>, akpm@linux-foundation.org,
 mcgrof@kernel.org, ysato@users.sourceforge.jp, dalias@libc.org,
 glaubitz@physik.fu-berlin.de, luto@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, kees@kernel.org,
 j.granados@samsung.com, willy@infradead.org, Liam.Howlett@oracle.com,
 vbabka@suse.cz, lorenzo.stoakes@oracle.com, trondmy@kernel.org,
 anna@kernel.org, chuck.lever@oracle.com, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, paul@paul-moore.com, jmorris@namei.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 dhowells@redhat.com, haifeng.xu@shopee.com, baolin.wang@linux.alibaba.com,
 shikemeng@huaweicloud.com, dchinner@redhat.com, bfoster@redhat.com,
 souravpanda@google.com, hannes@cmpxchg.org, rientjes@google.com,
 pasha.tatashin@soleen.com, david@redhat.com, ryan.roberts@arm.com,
 ying.huang@intel.com, yang@os.amperecomputing.com, zev@bewilderbeest.net,
 serge@hallyn.com, vegard.nossum@oracle.com, wangkefeng.wang@huawei.com,
 sunnanyong@huawei.com
Subject: Re: [PATCH v3 -next 11/15] sunrpc: use vfs_pressure_ratio() helper
In-reply-to: <12ec5b63b17b360f2e249a4de0ac7b86e09851a3.camel@kernel.org>
References: <>, <12ec5b63b17b360f2e249a4de0ac7b86e09851a3.camel@kernel.org>
Date: Fri, 11 Oct 2024 08:43:15 +1100
Message-id: <172859659591.444407.1507982523726708908@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_GT_50(0.00)[60];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 11 Oct 2024, Jeff Layton wrote:
> On Thu, 2024-10-10 at 23:22 +0800, Kaixiong Yu wrote:
> > Use vfs_pressure_ratio() to simplify code.
> >=20
> > Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
> > Reviewed-by: Kees Cook <kees@kernel.org>
> > Acked-by: Anna Schumaker <anna.schumaker@oracle.com>
> > ---
> >  net/sunrpc/auth.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
> > index 04534ea537c8..3d2b51d7e934 100644
> > --- a/net/sunrpc/auth.c
> > +++ b/net/sunrpc/auth.c
> > @@ -489,7 +489,7 @@ static unsigned long
> >  rpcauth_cache_shrink_count(struct shrinker *shrink, struct shrink_contro=
l *sc)
> > =20
> >  {
> > -	return number_cred_unused * sysctl_vfs_cache_pressure / 100;
> > +	return vfs_pressure_ratio(number_cred_unused);
> >  }
> > =20
> >  static void
>=20
> Acked-by: Jeff Layton <jlayton@kernel.org>
>=20

I realise this is a bit of a tangent, and I'm not objecting to this
patch, but I wonder what the justification is for using
vfs_cache_pressure here.  The sysctl is documented as

   This percentage value controls the tendency of the kernel to reclaim
   the memory which is used for caching of directory and inode objects.

So it can sensibly be used for dentries and inode, and for anything
directly related like the nfs access cache (which is attached to inodes)
and the nfs xattr cache.

But the sunrpc cred cache scales with the number of active users, not
the number of inodes/dentries.

So I think this should simply "return number_cred_unused;".

What do others think?

NeilBrown


