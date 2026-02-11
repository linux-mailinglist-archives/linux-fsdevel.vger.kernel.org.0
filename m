Return-Path: <linux-fsdevel+bounces-76915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA9mFFHUi2njbgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 01:58:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC855120664
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 01:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59691306C442
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 00:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A236723E33D;
	Wed, 11 Feb 2026 00:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Akfn2is4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C252238150
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 00:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770771518; cv=none; b=gN+vF43Qhyg2uoCJZ4ZpI+Ne8iWVKfl5ZVw9am6OduAi62+8qHt7OoN/MhEKxOzl/JAVQwr3sm5w+tg+yVhwHtQXqyVLkIqjJu9pHRDld0PsqQEgDAu1Sfu1MXMmyX9INAa3EOIGzNMNHoBOsfsNj5gviohGmKzKsSgfRs4v2Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770771518; c=relaxed/simple;
	bh=LPkENCCP9Iv6HhXNQjJR1VmZFQn/KyEBDTPnLHglPbw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1VQDnCcvqvK2cMQKMNK38jTVpnSuirLzyuWwPx6pESR+3dVpvjKc1H2H4Ut5JySPMNHeNECq7Q2C7OHkzd0KRsFxXUdI6e/KwdogpmrC3cgNLL5p4oWPcD+QDWq4MY1CJNDlcd3soDWFHjvB8rkYQCL6J8OULzExT3ZTTN8HqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Akfn2is4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so21122485e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 16:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770771514; x=1771376314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=saJTqKZgiPh9XrzB25Qr60CmTdAWHKEeFeS9gn6orw4=;
        b=Akfn2is4k+a/B6dkDnutvK/7shZRpZiimwru1J5NtkoXoUZqyNNMyxszt2JcHZa3A+
         zdy7NLwXJhp1qXH4OraSD4rylrVpF+kfb+jgTX96R9pmm86zPVPHGiien/mv9MSxjnO4
         aPPJ+9OpT76BlNm0zskwzbux5l3QVXXXWH3QC0qs6QXw0TpvHOfWpKd2UQGGlXgN6f1S
         I0NBKwe9lKLSwmOrbLeP8+X0IFZ7pniULMtHOXPoL13tMWnVCEES5109mAQ8+6Upbag+
         q95HWgmyY5OjKEv4udE8uaYuVpx7toxT/NqgYUEp9PutuGGewaBy+bi8auYzMWNNPG7+
         gowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770771514; x=1771376314;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=saJTqKZgiPh9XrzB25Qr60CmTdAWHKEeFeS9gn6orw4=;
        b=SqFLf4+2LDPzPlqxxoPMs5B4bbJhBBXHxssxaV6OFURSXrlcmFlXGUMZVuP5K0k3WM
         d+NiOK9J2XUlbhAT2dRu6SQyeE6dTksIb+6jEQwiiqKZhnf3DKc8bDtRFdM30M5JAgOC
         tOHDBYxZMHePrdM5ya6iIjCs4jaX7XsJlcQchonqZNtXa/tXq+jCb1BY7CVkcjEbuUQ6
         1ga+AmeHSuNTS830Qhv1z1d40Em5iMxzQbJytgkzs9p2CkGfFELiEnCK6yzu6YKJX4DW
         dYCIks1njoiaHEBOAYQa5Nw1Tge3EOBwiAXf645XoD4ibippPyYoBWJPrDzJkNSd6BRJ
         SNPA==
X-Forwarded-Encrypted: i=1; AJvYcCVSEqGLdOA0QlTCIZGA6Xe7CkXMeyhAYVT1Uuu3VuoE01wf3WkXa8Lk2msaQqNIsGeABe7SeNgfcSI4WhIa@vger.kernel.org
X-Gm-Message-State: AOJu0YxIxF5whHfMwYebq4oXx0yUpwQxs5r3Hyo5IzPRcTdUW67eEsMA
	YrylWHqNTPkcSDNpfDXershHGskcOIv+Wc3aiwnsKBUZafheThKK5ahV
X-Gm-Gg: AZuq6aIwyFR0yR7779Wstk3kyJrBdL2FSt6HNrq8XzUk4+xUaYCmAxETt7gGnMxYE8u
	KLW0pFE3XMjR6ZNZ5F1MbFhZvJ6+gvWA4YuxYfrKoAMzRY0jMSngRHKEbdpm7aKror5Y5+4Tu5/
	+QchZn29ooQmaZQnGWmAEP4MrclVOzr3hossKPjuTbxwzEtg90NlTPVqVSPcsenJDRWtFFfVSvp
	YNQGC2tO3WuOL6VGLpz5wabWWP+czxyB4IMv4BANJywGzm1WzcaPVq/C7otQjHfs4e0vKxZeeFh
	BnxUPWfVU/gOiWNlHB7O22NtaQ22XhVkrjwXt5s0sKugoF5Euz4Y33MRrq+/uq/x/jisJPEM6t+
	GnEhjWmL87qHY8oC4TCU5sZ7OQS+Gglhhf39Okaaf9RA+9jx7I1HfnpBLnK38o38j8jJZ5yVwrV
	TFy7t1q98jpuj35Ks8+dq3aOwCLpRjR5qCzP+CrF+K5tNBbrD/HRgcoA==
X-Received: by 2002:a05:600c:c4a7:b0:47f:b737:5ce0 with SMTP id 5b1f17b1804b1-48320231161mr210550075e9.23.1770771513861;
        Tue, 10 Feb 2026 16:58:33 -0800 (PST)
Received: from Ansuel-XPS. (93-34-90-125.ip49.fastwebnet.it. [93.34.90.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835bc7bd3fsm4806675e9.18.2026.02.10.16.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 16:58:33 -0800 (PST)
Message-ID: <698bd439.050a0220.38f6b4.a251@mx.google.com>
X-Google-Original-Message-ID: <aYvUM4J9anl2Bpkc@Ansuel-XPS.>
Date: Wed, 11 Feb 2026 01:58:27 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: David Disseldorp <ddiss@suse.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] initramfs: correctly handle space in path on cpio
 list generation
References: <20260209153800.28228-1-ansuelsmth@gmail.com>
 <20260210223431.6bf63673.ddiss@suse.de>
 <698b6ced.050a0220.9e34a.3e08@mx.google.com>
 <20260211113308.4c5b0b82.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211113308.4c5b0b82.ddiss@suse.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-76915-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mx.google.com:mid]
X-Rspamd-Queue-Id: AC855120664
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 11:43:10AM +1100, David Disseldorp wrote:
> On Tue, 10 Feb 2026 18:37:44 +0100, Christian Marangi wrote:
> ...
> > > > diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
> > > > index b7296edc6626..ca5950998841 100644
> > > > --- a/usr/gen_init_cpio.c
> > > > +++ b/usr/gen_init_cpio.c
> > > > @@ -166,7 +166,7 @@ static int cpio_mkslink_line(const char *line)
> > > >  	int gid;
> > > >  	int rc = -1;
> > > >  
> > > > -	if (5 != sscanf(line, "%" str(PATH_MAX) "s %" str(PATH_MAX) "s %o %d %d", name, target, &mode, &uid, &gid)) {
> > > > +	if (5 != sscanf(line, "\"%" str(PATH_MAX) "[^\"]\" \"%" str(PATH_MAX) "[^\"]\" %o %d %d", name, target, &mode, &uid, &gid)) {  
> > > 
> > > This breaks parsing of existing manifest files, so is unacceptable
> > > IMO. If we really want to go down the route of having gen_init_cpio
> > > support space-separated paths, then perhaps a new --field-separator
> > > parameter might make sense. For your specific workload it seems that
> > > simply using an external cpio archiver with space support (e.g. GNU
> > > cpio --null) would make sense. Did you consider going down that
> > > path?
> > >   
> > 
> > This is mostly why this is posted as RFC. I honestly wants to fix this in the
> > linux tool instead of using external tools.
> > 
> > So is there an actual use of manually passing the cpio list instead of
> > generating one with the script? (just asking not saying that there isn't one)
> 
> Absolutely. As a simple example, consider an unprivileged user wishing
> to add a device node to their initramfs image. A manifest entry (as
> opposed to staging area mknod=EPERM) is ideal for this.
> 
> > One case I have (the scenario here is OpenWrt) is when a base cpio_list is
> > provided and then stuff is appended to it.
> > 
> > In such case yes there is a problem since the format changed.
> > 
> > My solution to this would be introduce new type that will have the new pattern.
> > This way we can keep support for the old list and still handle whitespace files.
> > 
> > An idea might be to have the file type with capital letter to differenciate with
> > the old one.
> > 
> > Something like 
> > 
> > FILE "path" "location" ...
> > SLINK "name" "target" ...
> > NODE ...
> > 
> > What do you think?
> 
> Introducing a new type to handle space-containing filenames isn't a bad
> idea, but using capital letters to signify the API change is confusing.
>

The problem of a new type is that other tool might not support that but no idea
if it would be really that relevant. After all it's all intermediate file to
generate the final cpio.
 
> > The option of --field-separator might also work but it might complicate stuff in
> > the .c tool as a more ""manual"" tokenizer will be needed than the simple
> > implementation currently present.
> 
> What happens when someone wants support for filenames containing spaces
> and quotes?
> 

I mean... it's a less common case where filename start to have almost invalid
char but yes it's a valid point.

> > I'm open to both solution. Lets just agree on one of the 2.
> 
> I don't think any of the options will be particularly simple, but
> nul-byte delimited field support might be the most straightforward.
> 

Yes that was the initial idea but was quickly scrapped as major work is needed
in the .c tool to handle NULL separated entry.

Can you by chance point to me how the GNU tool work with --null ?


They also create a cpio_list file with entry NULL separated?


-- 
	Ansuel

