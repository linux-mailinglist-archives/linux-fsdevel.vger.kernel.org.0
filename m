Return-Path: <linux-fsdevel+bounces-53993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF99CAF9CB8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 01:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3861BC5F61
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 23:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0867328E611;
	Fri,  4 Jul 2025 23:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAR+xgBM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E3221B9D6;
	Fri,  4 Jul 2025 23:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751671750; cv=none; b=QcXCmpMW9tBPXdw5eYg6kdCuldrjkHQO+ujdOYrMAe4arJkfFzgOAaSWPainP/kFNBrHpWNvN+3PZalfzBVtugfhzSG8jCFGC5Lqk6CB5frx/Bk5K4bjReOxPGChflwEp0da65PFbKk0L2t5Guj+XBI0FF+z8CjhVKL1iQ+VApM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751671750; c=relaxed/simple;
	bh=tb8VBPJk816dMuwf1mAIMCyy1yCn7uftotKSToGx4zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKNHhCFG7DpMDUtC9XDWkzd6T7bnbmPbNLfAEHmkUSMmmIYPIeCoeauJknJK4BYGl4AMtUE4jcZJCh3VNG1cTGDzjyxB/ZAgqgXFQvVeemmcvmIuUc3LoA8gCJM9/x+22xOObR7K/j6aeztRuU2unhmQCZ32BetUseCAbSJwuso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAR+xgBM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2349f096605so19118525ad.3;
        Fri, 04 Jul 2025 16:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751671748; x=1752276548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QuwFRRF8QKbV+T5Rtpk9+ke6COijCSDaKe6s+BtINKI=;
        b=CAR+xgBMu7kc/1h5Pw/O9CNDxEIphIPEAJ4E9kTBmLIoha6WJLsmjEfgMiszDuRA19
         P1V2MDc8IosRyEdJRaB0z/davaAS3TUgMJU1oy9FnEqbVe3X4fesjlu9bM42j3bCPzpK
         0iej9fKg6zW3fuNxIjKvkQIO8MU6hhzd6ko4m+ziHA/TWlhFwdrzHDG5TkQVGBKx1JoR
         IDPBJR9URwP+tYm+7Qm5zOAq4Wa/MjkvMP1+tz6F3uOsItODyfIacXBYxgtktUs3yJa4
         lPxpxmEATs72+xbAXDvmllv05XoU9wDlJIcW/1GkqLsAk+9gLOcbd7nnyopEbGlvEv8T
         G4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751671748; x=1752276548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuwFRRF8QKbV+T5Rtpk9+ke6COijCSDaKe6s+BtINKI=;
        b=fuAKarm7XymXCMYFFwL3Un/4aol28ds3O+hj9RieFCq4Gv6PZSQj1UP1bHioNlySUH
         af9gV/Uo72PEkWJ6MBNQTKzpNG5eIbFC0Ve6YJDjiQxBl7DupoYIcwtg1LGUqjWLnqtM
         qrz/8zp6sp31BDeXNevcm0b/sfy71FwiYnb4HzaHq5pguI0LQPtlywbl8JISPN8zqZEw
         e27yg7XXd8tiNEN2T0HJaFhgz0vOKNunFaxyw+HZkF1cJBmovnewmxv1WPgKYQ6r4eGE
         ovmW8aJVJV9sRLhexM6BglutCmjeEWQsl4vQtzvDMLa1XwYeHjo9eZLIZoieypy+EKvf
         /X3A==
X-Forwarded-Encrypted: i=1; AJvYcCUutCC6b7y1GKFyeLxPNbmOk9Jg/9WG7g1Cch1h6LMz6pzOYYPWmLoi6rFcc5/g+oCiN0bJlb6aBYAPok64bA==@vger.kernel.org, AJvYcCVbywO+7Ea+v8GorTY6Jh8qWLTigk3ppNohv4YhhtuAnl5m7eZFxZmUWOH/OgE88Nt6KRdPwiDra+U=@vger.kernel.org, AJvYcCXVTLGXorGGPAt1b44J6UTGp5Zftsq805pGktRnb0Z3VLeZMfxETSMrXBHYeVWnB/PZ8v3zXbP5bwMj+kZc@vger.kernel.org, AJvYcCXw+Q8xTt6QwaY/Nk6LFyl0EpCxEzs1QfFAh17din1nI+d1H/LdXXiO3R+NN6zdM9jh+gcocXUJjmIO@vger.kernel.org
X-Gm-Message-State: AOJu0YznCxLnuQmmNKQ7yPWXdozmJ4v8mWVTm5NFJTVesmNhFwMJCVGI
	N2RAISGdAocebunj4pEInmZGo089gtXXJPRvI/pZ+766BYV+PdsHxy0H
X-Gm-Gg: ASbGncuiJRjgAHVAjFhSfoaOhZKrU5oW/5NM6lpFL7QFNWeuau3k4fIO2tidJO/se7/
	Xe8xRoBDXkC0J01KwmNqqkKfp6ETp30wr5jXLAc37UZjtPe/alSNq3NnugCOHrYT/zpg6a4RsFX
	rKIPsulcYSiqyP5M6SiQ/g0vZbG9gKCfFpld0UI237rYFYsNqCf+0JpqcfXj60BT1HkUz0TFmR+
	MgVF44zoOeNMo/r0KMulMuCjrWyANPUtyboU481kdvsfTFG+jGAlUlRr4/HToHzPbKN5eFRIjKO
	7YpiRt47a8m7ARo2JTUxP83S1luhlkTLQo1IgthAEcD3x/KSyMS2detY1SQQuA==
X-Google-Smtp-Source: AGHT+IEmWW8RNAKSZbgocL/eZEJbLbFOSAUUCEKiyVb4oP1j89S88LZhuuNGHm/fWdWQBli8Lf9cWQ==
X-Received: by 2002:a17:902:ccc4:b0:235:e942:cb9d with SMTP id d9443c01a7336-23c8747dfafmr48499875ad.17.1751671748171;
        Fri, 04 Jul 2025 16:29:08 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c845bdfe8sm29463235ad.244.2025.07.04.16.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 16:29:07 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 0D9A54206889; Sat, 05 Jul 2025 06:29:03 +0700 (WIB)
Date: Sat, 5 Jul 2025 06:29:03 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, John Groves <John@groves.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredb.hu>,
	Bernd Schubert <bschubert@ddn.com>,
	John Groves <jgroves@micron.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 18/18] famfs_fuse: Add documentation
Message-ID: <aGhjv37uw3w4nZ2C@archie.me>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-19-john@groves.net>
 <aGcf4AhEZTJXbEg3@archie.me>
 <87ecuwk83h.fsf@trenco.lwn.net>
 <aGdQM-lcBo6T5Hog@archie.me>
 <aGgkVA81Zms8Xgel@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aGgkVA81Zms8Xgel@casper.infradead.org>

On Fri, Jul 04, 2025 at 07:58:28PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 04, 2025 at 10:53:23AM +0700, Bagas Sanjaya wrote:
> > On Thu, Jul 03, 2025 at 08:22:58PM -0600, Jonathan Corbet wrote:
> > > Bagas.  Stop.
> > > 
> > > John has written documentation, that is great.  Do not add needless
> > > friction to this process.  Seriously.
> > > 
> > > Why do I have to keep telling you this?
> > 
> > Cause I'm more of perfectionist (detail-oriented)...
> 
> Reviews aren't about you.  They're about producing a better patch.
> Do your reviews produce better patches or do they make the perfect the
> enemy of the good?

I'm looking for any Sphinx warnings, but if there's none, I check for
better wording or improving the docs output.

-- 
An old man doll... just what I always wanted! - Clara

