Return-Path: <linux-fsdevel+bounces-46594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32936A90E06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 23:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14543B0536
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 21:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD505236456;
	Wed, 16 Apr 2025 21:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnKtegqF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A601DDDC;
	Wed, 16 Apr 2025 21:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744840265; cv=none; b=liyI+5g6IB7xcsjITqvNB2hfb3ez3zLYTQzuVR6wmu7JRmWdrCIL6wXN33RSukL5rREPaPlj8p4h5rZcrElaj3G9v+r9PdS2PoV+wTfjcemJNBXx9Z8MwGqV9rQoQwI+zEgYketrOjLUCnmZdRyTqeV5AFxufFfO3Ro4IESP9bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744840265; c=relaxed/simple;
	bh=ml9afDM/3Yzyfwll0P+8N2de4+3ysKmPCf/iDrKlRCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqQYstfbz37/x53+ES6vAMOtf2pYx9ZxEOA46+reb9YTuckjmcpGMQbU30N5TNOf1YiHXTnr8+nNZx4+UkxQGUSotLSmUZ4LW/G/zGGsggNdmArP/beDGKgQmyw5BHwMwuYccEcLhYHr6nOppv1UB2W2gefqEsniwnbfAKAwGWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnKtegqF; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so20519866b.1;
        Wed, 16 Apr 2025 14:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744840262; x=1745445062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJdJaIYbEx3ZRtOqC4BE7tYp0utl0F2tybjya7bRNag=;
        b=dnKtegqF0nShYol7EoGMd+jNgx7k4Jv76YRWQKiQQ7Fn73XNnpTJth8zdWaDq/6Uzl
         siX/3W3xrixVBySRK0z6F67B8/diTRuZM+sdE8UPb+tw9/CEEBKvTBHvZOXJNiNV8dRS
         dnIZ+zD8WmAJmPpdlje9GP0PXslNnYDl2wcCqLW34qTVbSzTiXFBN0dbWwFd4kuONnTW
         9WS78dLT0GDdGTATOD4a6ykgO7MIm+qwzwG2+XxSz5PXCCpw4vsCNjJjZilrDcLdZxZT
         j6pvdx3GfeiX547jxaVu/Ef8X0gHntOMfp1VKfoS5RAUKikkNMf7OEyM6nb+Pe5gSi7j
         UNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744840262; x=1745445062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJdJaIYbEx3ZRtOqC4BE7tYp0utl0F2tybjya7bRNag=;
        b=XuddnNi7Ymf0hdPsNTjBCe8yAp4ALO2WGxw8iq24NsmsI+MHKU3k51hhd3M6UjLuj4
         x0tOZcsfjFPUDUPMKrYITmNFH14alCnkRLzz0hwfmdZD8QMlc4+eeLIh9wVEF09q4Rf8
         9qUkY+VxE8HqFXsljLtbfjWOnrrwIyzqvELvNtp6Fnhfph1ve9x1YThyPzud5R1Dlr6N
         ETbkl6PBv4cgVMtUMg1w/5TasB+uzRec1mSlXCKjXSgYvP1sd/zW5I4oOW3qCkiwa00h
         xbe9rRCGXR1z5K1ydIlX8WkEat2CY5oSg+eZ93BqODmSyzVYJWtOWfyJIUzubbhKv2GS
         OmqA==
X-Forwarded-Encrypted: i=1; AJvYcCVgppGHn4kvheA8GnwWSne7uyEs4OLbRdF/Unt7Uw4Is8QF8x8Yb76+DCMdM4UcQl5/e6LFcieECHBm/Q==@vger.kernel.org, AJvYcCXpsFtsCIHvfMBZTM7kmp8sE2nahdHCj1F/LK1YStnJUrEP5VkXuRCRcS1+D1XZW+IXm6QQafaMlysYeVIP0g==@vger.kernel.org, AJvYcCXvyM6HQHIHL91huSuE/ZK90bFeqiHLNhljEDJqoDohihG7Er2mygQjBahPn2XhAJ8o1AMRp6E3gWvYu9yO@vger.kernel.org
X-Gm-Message-State: AOJu0YydtQO1QvfPHGTLc8a2u7VlMfpAjzJkV6hMI7S+JkEW0aM4Ogn0
	V2GGt0dryX50+yfBamIK7VJNiN120j30QuZY6mDMM1ZNmnXkKyTS
X-Gm-Gg: ASbGncvp/B8EASerGItDDO+XccBFehz7GPREsZWUQOPsRD/hisOPfqqsTfXBK22Wf32
	IHyyO124lPjRFLOeJrUBUwUT4xaYg6f12SHapDSVZcRMY4ht/1UwgCclRRBAFtB813sKpN7mljC
	rOxZvB6sI6LWzv3+ynEwX8+FTay/lsiTeV0fkmB6zWgzRst2FldC9iZOKdhV9IjC7v5LjB4mrZ9
	oOJvfgkUJY6HgdyP+8SghRavTQWM+Ncr+gheJISpD1so2+4QlNM5ZszG3OYeLqHMeWX/wYlklAy
	KURQBvDXSHl3d6oXb+9T3PkrzWgIjRYOCqVoSg7gxywiBfWacvaev9HFDNqepTYbJIk9dWgFZxo
	svC78Zor0
X-Google-Smtp-Source: AGHT+IFK4dqVh9IwS7sEmyZQt6Kkrhj7u3AOMF7Z1XeZVWstA/f0rOPaMBIQ6cg6ig8xLchc+kWfkw==
X-Received: by 2002:a17:906:d542:b0:aca:e0b7:de03 with SMTP id a640c23a62f3a-acb428f20d5mr382338566b.16.1744840261325;
        Wed, 16 Apr 2025 14:51:01 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f527ee8sm9378835a12.73.2025.04.16.14.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 14:51:00 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id CBD3ABE2DE0; Wed, 16 Apr 2025 23:50:59 +0200 (CEST)
Date: Wed, 16 Apr 2025 23:50:59 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: David Howells <dhowells@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Hillf Danton <hdanton@sina.com>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	regressions@lists.linux.dev,
	"stable@vger.kernel.org Bernd Rinn" <bb@rinn.ch>,
	Karri =?iso-8859-1?Q?H=E4m=E4l=E4inen?= <kh.bugreport@outlook.com>,
	Milan Broz <gmazyland@gmail.com>,
	Cameron Davidson <bugs@davidsoncj.id.au>, Markus <markus@fritz.box>
Subject: Re: [regression 6.1.y] Regression from 476c1dfefab8 ("mm: Don't pin
 ZERO_PAGE in pin_user_pages()") with pci-passthrough for both KVM VMs and
 booting in xen DomU
Message-ID: <aAAmQ-sRQhejItzQ@eldamar.lan>
References: <Z_6sh7Byddqdk1Z-@eldamar.lan>
 <20250416142645.4392a644.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416142645.4392a644.alex.williamson@redhat.com>

Hi Alex,

On Wed, Apr 16, 2025 at 02:26:45PM -0600, Alex Williamson wrote:
> On Tue, 15 Apr 2025 20:59:19 +0200
> Salvatore Bonaccorso <carnil@debian.org> wrote:
> 
> > Hi
> > 
> > [Apologies if this has been reported already but I have not found an
> > already filled corresponding report]
> > 
> > After updating from the 6.1.129 based version to 6.1.133, various
> > users have reported that their VMs do not boot anymore up (both KVM
> > and under Xen) if pci-passthrough is involved. The reports are at:
> > 
> > https://bugs.debian.org/1102889
> > https://bugs.debian.org/1102914
> > https://bugs.debian.org/1103153
> > 
> > Milan Broz bisected the issues and found that the commit introducing
> > the problems can be tracked down to backport of c8070b787519 ("mm:
> > Don't pin ZERO_PAGE in pin_user_pages()") from 6.5-rc1 which got
> > backported as 476c1dfefab8 ("mm: Don't pin ZERO_PAGE in
> > pin_user_pages()") in 6.1.130. See https://bugs.debian.org/1102914#60
> > 
> > #regzbot introduced: 476c1dfefab8b98ae9c3e3ad283c2ac10d30c774
> > 
> > 476c1dfefab8b98ae9c3e3ad283c2ac10d30c774 is the first bad commit
> > commit 476c1dfefab8b98ae9c3e3ad283c2ac10d30c774
> > Author: David Howells <dhowells@redhat.com>
> > Date:   Fri May 26 22:41:40 2023 +0100
> > 
> >     mm: Don't pin ZERO_PAGE in pin_user_pages()
> > 
> >     [ Upstream commit c8070b78751955e59b42457b974bea4a4fe00187 ]
> 
> It's a bad backport, I've debugged and posted the fix for stable here:
> 
> https://lore.kernel.org/all/20250416202441.3911142-1-alex.williamson@redhat.com/

Thank you, that worked (replying here as well mainly to fix my mistake
in the CC to stable@vger.kernel.org, which got truncated to
table@vger.kernel.org in my initial submission).


> 
> Thanks,
> Alex
> 

-- 
  .-.  Salvatore Bonaccorso --------------- Debian GNU/Linux Developer
  oo|  ----------------------------------------- http://www.debian.org
 /`'\  GPG key ID: 0x789D6F057FD863FE --------------------------------
(\_;/) Fingerprint: 04A4 407C B914 2C23 030C  17AE 789D 6F05 7FD8 63FE

