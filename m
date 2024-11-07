Return-Path: <linux-fsdevel+bounces-33976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D10C9C11A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 23:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3CB1C221D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 22:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E57218D7D;
	Thu,  7 Nov 2024 22:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJaM+unM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1787218D64
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 22:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731018151; cv=none; b=saQ0ThThWSP8E31wzO11cUH+CMGj+s+V9a+P1pAQjJJn37ZaRoxs9dF0af5mx9mEnPjZsFNtljiILyTUcqqV3fMWXDDheJFNCvFcoxzT2fTtewBNdjUzxDRmAbX1DC1cVTWAtI5Nq/R+o2C9S6Z9gHNSAfzOQQI4MAxjrQJsz1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731018151; c=relaxed/simple;
	bh=vbiiK5s0HFH7enusbvvY69b81sO3o9ywaBdVN4VWfcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eARKPTjDFUpIrDOeWnDYipvd4etECS1nqZtb0rvK14jMBok8PzRrKJ4pX6IyseLJsB6PtBy/6W/js63khdcdWYa1UQD/+Sulpjgy7IRSmjBZNWjMQnoPwI5JYHuI5ydscxVERnjSFViUQnSCIv67u+v+zt7P34mzm1QsOtzLqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJaM+unM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so13498205e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 14:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731018148; x=1731622948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/SNWr8oNBc1bO1oQ+Jn+ysVNTdV3p4zQURl3AH9mEw4=;
        b=dJaM+unMvPAiQlMNhhee1L3mcMxWJCYQp4FJDDcYOnOJAmX0qkv1DtOVwZSV7G18wA
         YiFJZriT87PdOfb9j4JiWVMh3TB9xRD0+06iVAeeMlRKwamgX5O1RB9cn9HpYglfePVR
         h/dL6aX1nnik4jB+P1idypkBBRqQeujMuqSTkYvknyXvvA41zBsVoWctJtDh/dX4HU7G
         67Mxovr4M5wWc0G875A2nHt7IAJEGE5OqkmRtbm4NBg1g/qc2xa1KJvyWzSVL/7Ik4Hj
         uXWWykBrrXVutFg7tWwN+jZgaQFyp8XGxY2O4VADsmTCWl037vCu4cEzxg9cuUuxpFnB
         lsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731018148; x=1731622948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SNWr8oNBc1bO1oQ+Jn+ysVNTdV3p4zQURl3AH9mEw4=;
        b=YKyMT6cvfBd/6gJ74svZyF4JPY205e2O44A8qyqeHv0wdgYHnkrV7yxW//9GepT7Xa
         Gfnt2UmRgLsZqwm0aYEGf0bbtV7/ZaqE+iVWvH5NMLHs8WsPmg8Ycw+/Dcb62oWTO+Px
         KSodHOcvR4TVrXgClqFEi8nXVlzyIkXrwgW3nGMwxBM2kDj66mv5Rm3sU/qaQh5mm26y
         4ySGHtzEkfpHKY3r6jiukVU+XBYoE2C7KjLIOKbhuLjlJ76lx9Qi1fOIH9SgiU+OHZj6
         AW0MI1bKhW/RCXbxgfJWVbWaPC7b2rc9DUyhH6O3VrNH/CuHOEvPMDqZH3kw7wlkSRcF
         PSqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo/xqheLzCRr3fGwDRXvlZLwwwKc3D3bY2qAZU1iV5Kg73j0h+NivqO1k9Gk61CBBlo2ziDQY+gWdM+Jy3@vger.kernel.org
X-Gm-Message-State: AOJu0YxsW9EMqsXtEi4ohS+H0Tkca7bWL6S795oAumRhD2BHpYIqULp+
	8UXqsW9wogOjTDNNfUMsQ+2jGyB13O2HySqolO/R9zVCUur87N/f
X-Google-Smtp-Source: AGHT+IFioPDUzFyMcA4xLKz8ofD3+sF40o01GM4YxEOyd/SJeWJYRle0Dcqf2Fi5PuI4D6FAPtImVw==
X-Received: by 2002:a05:600c:1c9a:b0:42c:b9c8:2bb0 with SMTP id 5b1f17b1804b1-432b74fc837mr3403455e9.4.1731018147548;
        Thu, 07 Nov 2024 14:22:27 -0800 (PST)
Received: from f (cst-prg-87-218.cust.vodafone.cz. [46.135.87.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda03696sm2841698f8f.87.2024.11.07.14.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 14:22:26 -0800 (PST)
Date: Thu, 7 Nov 2024 23:22:15 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: generic_permission() optimization
Message-ID: <a7gys7zvegqwj2box4cs56bvvgb5ft3o3kn4e7iz43hojd4c6g@d3hihtreqdoy>
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
 <20241031-klaglos-geldmangel-c0e7775d42a7@brauner>
 <CAHk-=wjwNkQXLvAM_CKn2YwrCk8m4ScuuhDv2Jzr7YPmB8BOEA@mail.gmail.com>
 <CAHk-=wiKyMzE26G7KMa_D1KXa6hCPu5+3ZEPUN0zB613kc5g4Q@mail.gmail.com>
 <CAHk-=wiB6vJNexDzBhc3xEwPTJ8oYURvcRLsRKDNNDeFTSTORg@mail.gmail.com>
 <CAHk-=whSzc75TLLPWskV0xuaHR4tpWBr=LduqhcCFr4kCmme_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whSzc75TLLPWskV0xuaHR4tpWBr=LduqhcCFr4kCmme_w@mail.gmail.com>

On Thu, Nov 07, 2024 at 09:54:36AM -1000, Linus Torvalds wrote:
> On Thu, 31 Oct 2024 at 12:31, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Added some stats, and on my load (reading email in the web browser,
> > some xterms and running an allmodconfig kernel build), I get about a
> > 45% hit-rate for the fast-case: out of 44M calls to
> > generic_permission(), about 20M hit the fast-case path.
> 
> So the 45% hit rate really bothered me, because on the load I was
> testing I really thought it should be 100%.
> 
> And in fact, sometimes it *was* 100% when I did profiles, and I never
> saw the slow case at all. So I saw that odd bimodal behavior where
> sometimes about half the accesses went through the slow path, and
> sometimes none of them did.
> 
> It took me way too long to realize why that was the case:  the quick
> "do we have ACL's" test works wonderfully well when the ACL
> information is cached, but the cached case isn't always filled in.
> 
> For some unfathomable reason I just mindlessly thought that "if the
> ACL info isn't filled in, and we will go to the slow case, it now
> *will* be filled in, so next time around we'll have it in the cache".
> 
> But that was just silly of me. We may never call "check_acl()" at all,
> because if we do the lookup as the owner, we never even bother to look
> up any ACL information:
> 
>         /* Are we the owner? If so, ACL's don't matter */
> 
> So next time around, the ACL info *still* won't be filled in, and so
> we *still* won't take the fastpath.
> 
> End result: that patch is not nearly as effective as I would have
> liked. Yes, it actually gets reasonable hit-rates, but the
> ACL_NOT_CACHED state ends up being a lot stickier than my original
> mental model incorrectly throught it would be.
> 

How about filesystems maintaing a flag: IOP_EVERYONECANTRAREVERSE?
The name is a keybordfull and not the actual proposal.

Rationale:
To my reading generic_permission gets called for all path components,
where almost all of them just want to check if they can traverse.

So happens for vast majority of real path components the x is there for
*everyone*. Even in case of /home/$user/crap, while the middle dir has x
only for the owner and maybe the group, everything *below* tends to also
be all x.

I just did a kernel build while poking at the state with bpftrace:
bpftrace -e 'kprobe:generic_permission { @[(((struct inode *)arg1)->i_mode & 0x49) == 0x49] = count(); }'

result:
@[0]: 5623736
@[1]: 64867147

iow in 92% of calls everyone had x. Also note this collects calls for
non-traversal, so the real hit ratio is higher so to speak. I don't use
acls here so they were of no consequence anyway btw.

So if a filesystem cares to be faster, when instatianating an inode or
getting setattr called on it it can (re)compute if there is anything
blocking x for anyone. If nothing is in the way it can the flag and
allow link_path_walk to skip everything, otherwise *unset* the flag (as
needed).

This is completely transparent to filesystems which don't participate.

So that would be my proposal, no interest in coding it.

