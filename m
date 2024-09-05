Return-Path: <linux-fsdevel+bounces-28742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D2F96DB46
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 16:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E7B1F29692
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD05319D082;
	Thu,  5 Sep 2024 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fzkBDS/8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8892AE96
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545578; cv=none; b=DcXbhZAYvRmhvHH1HGOqV/o80hX9M77RyCm4VM6fVc+gXLaGJucso3550QymBrEez+IYh4AVpw+ji8hCONF6IjAu+lxHiuZQhD1wtrb2yh6w21XosBD9I07FCqfEDzBCezhbVV9f/XgXRTXYPJxKk81uQGCe3PJGntUmN7/nn00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545578; c=relaxed/simple;
	bh=gIpwCb6OV6UwPMTwnRjpauWp1JHz59zzWwEgm74aOlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKP0v7Fe+R/2fj3FHjCGL02015C9OmUkZwbnCaBfqx91X+cMVH9g2Mm+QDLJmlw/hmWQwp+uw7MfYvF7Tl8gWPV9KSG2UoJS8iowSQ8t8DRyC3EIpOF7lDUxBJptE7IPclJD3Z7z6sqvEN56OXwRGpdpBk5s0T+Q7tu/+5/t+qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fzkBDS/8; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5343617fdddso1289367e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Sep 2024 07:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725545574; x=1726150374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gwYsBihYTyfOkMwcrQ2PgVwPBmg+Ta54Eew3ioB7SiQ=;
        b=fzkBDS/8pvFq4Xc8f/Fa2RY3BiXmomhg0qoazjTcSjQXm/YO48sC4nMS+/dZJmrFbM
         Yhd4jGUFonnzfk1cWfmKUILW7d9OwsbSSvnb0AA44rNsdcEAg/IvdfB5zJmR0bS45+Bw
         27FsoiC9HRTJth/KITNi8Dq9n1kx/ueWUdninPQfhhj00Po/QviTMSO2+o4ttYItdreV
         uxQjUDzofWmqJ6+hoArSW6TSQZt+XzVBU6maC2kUohbxWsBDX27DbKFIIPMr5kSGmZw7
         zL18ZVt3lzrXxfmHnnz3V6F8bWLA+/e1MXul+HWl9OlOIXADIdXF4Mxs9JttIKeaWdLK
         06zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725545574; x=1726150374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwYsBihYTyfOkMwcrQ2PgVwPBmg+Ta54Eew3ioB7SiQ=;
        b=GIK1ip5PwPfkwp0UrADdnevPv8vVqy1JZvmkA89c9PSez3FER7WUHeKzvMn3zhbx72
         lLn/uZobdrpn1ofwdnxuHy3zsg929/jMdSXn+oz+/oFfQ16Wd6qLVlMBLblw8RfqL8zu
         fwBLGj3EFBxnFfkly4ZR6bdbNuD+zSoX5q/VkzSoxlarxDgnlLmbMcNmnmgLL6JICbZ4
         c4IPeufv0/nqmr5Bxg6NfbIE6vvvTfKo54DwE35xg3eWNHxwnPItOC5xF6qvZmSOgHle
         NJslAzOGLQrlCnRJXEKr7Di7kHYX2tJjNlwixnbZkheHFiUH0roUToSlOYy07pzL0Tl5
         hGHw==
X-Forwarded-Encrypted: i=1; AJvYcCWqNeJUrWH0EDZCWI+ZT3/wW0fNgvW5UE/DcJvTTJ46O3Eh+EthxzE3XtxugH73vH/TeGIZkl4zvm7CfEbO@vger.kernel.org
X-Gm-Message-State: AOJu0YzvR8PzuVvd28pptlbNtvUU3bhagepi9BvXxk9P518wb2NpnPVU
	3B6vUONKp9Hkxh7KtLqOcMOKSAoad5l+rkgtfDl9+M4ipGC+5JQTXzZ5WIuUcGY=
X-Google-Smtp-Source: AGHT+IGsTyoQo5r21FHK64nbduDdB0RMk5Y4ciVDsCqSQ9O4YP1mPL/j+bbkh4RnUZCAoKKWGupTJg==
X-Received: by 2002:a05:6512:a8b:b0:536:54ff:51c8 with SMTP id 2adb3069b0e04-53654ff53dbmr1077754e87.17.1725545574270;
        Thu, 05 Sep 2024 07:12:54 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623c2fa2sm142182366b.183.2024.09.05.07.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 07:12:54 -0700 (PDT)
Date: Thu, 5 Sep 2024 16:12:53 +0200
From: Michal Hocko <mhocko@suse.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Vlastimil Babka <vbabka@suse.cz>,
	Dave Chinner <dchinner@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] remove PF_MEMALLOC_NORECLAIM
Message-ID: <Ztm8ZY0kXWLFspYJ@tiehlicka>
References: <ggrt5bn2lvxnnebqtzivmge3yjh3dnepqopznmjmkrcllb3b35@4vnnapwr36ur>
 <20240902145252.1d2590dbed417d223b896a00@linux-foundation.org>
 <yewfyeumr2vj3o6dqcrv6b2giuno66ki7vzib3syitrstjkksk@e2k5rx3xbt67>
 <qlkjvxqdm72ijaaiauifgsnyzx3mw4edl2hexfabnsdncvpyhd@dvxliffsmkl6>
 <ZtgI1bKhE3imqE5s@tiehlicka>
 <xjtcom43unuubdtzj7pudew3m5yk34jdrhim5nynvoalk3bgbu@4aohsslg5c5m>
 <ZtiOyJ1vjY3OjAUv@tiehlicka>
 <pmvxqqj5e6a2hdlyscmi36rcuf4kn37ry4ofdsp4aahpw223nk@lskmdcwkjeob>
 <ZtmVej0fbVxrGPVz@tiehlicka>
 <20240905135326.GU9627@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905135326.GU9627@mit.edu>

On Thu 05-09-24 09:53:26, Theodore Ts'o wrote:
> On Thu, Sep 05, 2024 at 01:26:50PM +0200, Michal Hocko wrote:
> > > > > > This is exactly GFP_KERNEL semantic for low order allocations or
> > > > > > kvmalloc for that matter. They simply never fail unless couple of corner
> > > > > > cases - e.g. the allocating task is an oom victim and all of the oom
> > > > > > memory reserves have been consumed. This is where we call "not possible
> > > > > > to allocate".
> > > > > 
> > > > > Which does beg the question of why GFP_NOFAIL exists.
> > > > 
> > > > Exactly for the reason that even rare failure is not acceptable and
> > > > there is no way to handle it other than keep retrying. Typical code was 
> > > > 	while (!(ptr = kmalloc()))
> > > > 		;
> > > 
> > > But is it _rare_ failure, or _no_ failure?
> > >
> > > You seem to be saying (and I just reviewed the code, it looks like
> > > you're right) that there is essentially no difference in behaviour
> > > between GFP_KERNEL and GFP_NOFAIL.
> 
> That may be the currrent state of affiars; but is it
> ****guaranteed**** forever and ever, amen, that GFP_KERNEL will never
> fail if the amount of memory allocated was lower than a particular
> multiple of the page size?

No, GFP_KERNEL is not guaranteed. Allocator tries as hard as it can to
satisfy those allocations for order <= PAGE_ALLOC_COSTLY_ORDER.

GFP_NOFAIL is guaranteed for order <= 1 for page allocator and there is
no practical limit for vmalloc currently. This is what our documentation
says
 * The default allocator behavior depends on the request size. We have a concept
 * of so-called costly allocations (with order > %PAGE_ALLOC_COSTLY_ORDER).
 * !costly allocations are too essential to fail so they are implicitly
 * non-failing by default (with some exceptions like OOM victims might fail so
 * the caller still has to check for failures) while costly requests try to be
 * not disruptive and back off even without invoking the OOM killer.
 * The following three modifiers might be used to override some of these
 * implicit rules.

There is no guarantee this will be that way for ever. This is unlikely
to change though.
-- 
Michal Hocko
SUSE Labs

