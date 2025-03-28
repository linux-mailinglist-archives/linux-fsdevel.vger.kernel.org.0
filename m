Return-Path: <linux-fsdevel+bounces-45245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1D0A750F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 20:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72643B2CFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 19:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087BB1E51E6;
	Fri, 28 Mar 2025 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrAhur5P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BE61E2834;
	Fri, 28 Mar 2025 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743190813; cv=none; b=rN0WY0PTpKvFnUX3sODhUgRzw6MakWGGq2WKu+N+1LsSdzwbYNt3+fYCsOBdEcskcnnfwzSPVRrH6iPrYlxcgr5/lEE9cBEs9N6IPPLv1Ot5/bQkuwmrL1pASB9vTsrFA19559ngfhTmF73gIDwaQL75B9LGXn6x+KEfv2Oa+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743190813; c=relaxed/simple;
	bh=AZYy0LjIEPefi8qUCTyfilsf/W/R03EYRAIaRU2GyCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JX3FOt/u52JmPZiEpK/poyKDoHUNMxqt3YgKNTZifFGdIZBVjfJIaTvuRhD+RCL8mjn70dAO1GlStvEtJ+MY7ThGMtc6qzKAaXSwVbmx1WX+9wN5yzCEOsoH/efCNNE8D+v092xsFB9oksRht3KV6UuY7VEdsAM9dikQSo5GAaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrAhur5P; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso18374685e9.0;
        Fri, 28 Mar 2025 12:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743190809; x=1743795609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g31fT7NSuDFGL51p2N33yhjibxIznvd9yFRHBivHmWc=;
        b=ZrAhur5P4F89wsUL5Plj12L2iACfVbVVMAb0rYmU710RdEplQupYSr0snm8Hesb4rp
         j8+UrAwkepQbirwdHHVPTVUwRADOMHvhnSQRNZ3iScYwb/JX7IVj2APAflXIg1hEaUFB
         lv6Vi65QluX2pJS8uutDVVR94FAHyFu2W5durlML90a5J0UsCsfGMG2C5oOmhxb+o4Hn
         TKrF2aq2u4L5Ea83829E/W7hHksg2h8CwXgP0fzUXXvocR5CKb8K237FryUXHIWkbLSM
         fT0c2h5p10Rn+54gkyS9BSyR2liUeTALbWLg7LDsctP02QTBkLG0KzhR4XEzRvRYu2BA
         LVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743190809; x=1743795609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g31fT7NSuDFGL51p2N33yhjibxIznvd9yFRHBivHmWc=;
        b=KNi3RVkl/bml9l5QUKhJRYUTMW40b9nt0w3wiZbwz3XX8et3lLPDP2JxjztF1WI7Hz
         Ju9TEcm9NAByyMjvCR5K4oZjqbhb98YCvEptn1foS1U4ZZkLruhVjYr1UFUqgGwIy77t
         bVMlTgJERHTO1FM8O9l4ISagXUJYLtxGlWziwW5+f7HWGMDvbHn1uopwc5/0zEWg34Sp
         EltEFoxQHkgzogMmRwYTonhVXYJW1l4Pm+3RmTGt7GA3S6GmXsPHgN2ieOwe1kYTgR7N
         bz/pL09qUacV+pMPg6or/X5iTR5oq+TJJmWSGxHgACSRFp7poRJrb+VJTZePu4cL1C3q
         Z+lg==
X-Forwarded-Encrypted: i=1; AJvYcCX0ZE103EnRox3Plvt0U6c9NpLlkwXvZpy2Q+LjgXYdVrbbopfcdX5Rf/kvvQZHkjPN6a4FfnEskuZmbiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzoF5Oc6ZDtMvMi+8XJYSdZ09gUvBK4qgXO8u4TFQAPQFb47yX
	iuaORtPItJIXpWIi1ezxJ7odQyPbcoDsRYCMlQgEueeemBxlQLQT
X-Gm-Gg: ASbGnctCHF47bkSC7GoYyKKVqOzfvahYtUYc8rEqPjfvY/kpgwIox/6vS8LhhlQmaE3
	Z3Jog7wXvxfqlAuKgIzMlSKSFujXgbIgGX7u4JjgFwPrbcGi1ChUpsjQ7sw3tkK1m7E1biGDVoo
	VyP8BoctpsWfmT2+1T81HMkDH5rEvHeAPvyeorzkjpnsTqDdoycmq18gUoZWPdcA6MaFFd4k7eK
	AuHMlfZhACw2i8PZMd+aK5UsAWzNXeJCOEfZtVMdprTl9wV8BGByF7Cit7XwQTlx5V70dugf14U
	PhflWfo8E6U44AhVRr3SG+oFKmWwRCan7MHQo3qgkdnv1kC8Zn1sZWi9AgiD4MbdSjhvIJvi06r
	M1z5z+cg=
X-Google-Smtp-Source: AGHT+IFat3LQD2bYM0wWxojwoyAaPDw//AHXVVWtS8GsypDtyLqaQlbynQP5nlPu5Dh5zJYD7v0Qtg==
X-Received: by 2002:a05:600c:1e85:b0:43d:1c3:cb2e with SMTP id 5b1f17b1804b1-43db6205bf4mr9717685e9.17.1743190809247;
        Fri, 28 Mar 2025 12:40:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8ff02f84sm37004415e9.25.2025.03.28.12.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 12:40:08 -0700 (PDT)
Date: Fri, 28 Mar 2025 19:40:07 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jaco Kroon <jaco@uls.co.za>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 bernd.schubert@fastmail.fm, miklos@szeredi.hu, rdunlap@infradead.org,
 trapexit@spawn.link
Subject: Re: fuse: increase readdir() buffer size
Message-ID: <20250328194007.4768eaf9@pumpkin>
In-Reply-To: <05b36be3-f43f-4a49-9724-1a0d8d3a8ce4@uls.co.za>
References: <20230727081237.18217-1-jaco@uls.co.za>
	<20250314221701.12509-1-jaco@uls.co.za>
	<05b36be3-f43f-4a49-9724-1a0d8d3a8ce4@uls.co.za>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Mar 2025 12:15:47 +0200
Jaco Kroon <jaco@uls.co.za> wrote:

> Hi All,
> 
> I've not seen feedback on this, please may I get some direction on this?

The only thing I can think of is that the longer loop might affect
scheduling latencies.

	David

> 
> Kind regards,
> Jaco
> 
> On 2025/03/15 00:16, Jaco Kroon wrote:
> > This is a follow up to the attempt made a while ago.
> >
> > Whist the patch worked, newer kernels have moved from pages to folios,
> > which gave me the motivation to implement the mechanism based on the
> > userspace buffer size patch that Miklos supplied.
> >
> > That patch works as is, but I note there are changes to components
> > (overlayfs and exportfs) that I've got very little experience with, and
> > have not tested specifically here.  They do look logical.  I've marked
> > Miklos as the Author: here, and added my own Signed-off-by - I hope this
> > is correct.
> >
> > The second patch in the series implements the changes to fuse's readdir
> > in order to utilize the first to enable reading more than one page of
> > dent structures at a time from userspace, I've included a strace from
> > before and after this patch in the commit to illustrate the difference.
> >
> > To get the relevant performance on glusterfs improved (which was
> > mentioned elsewhere in the thread) changes to glusterfs to increase the
> > number of cached dentries is also required (these are pushed to github
> > but not yet merged, because similar to this patch, got stalled before
> > getting to the "ready for merge" phase even though it's operational).
> >
> > Please advise if these two patches looks good (I've only done relatively
> > basic testing now, and it's not running on production systems yet)
> >
> > Kind regards,
> > Jaco
> >  
> 


