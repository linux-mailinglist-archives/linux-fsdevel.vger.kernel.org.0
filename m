Return-Path: <linux-fsdevel+bounces-22535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A604918DE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 20:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5DE1C21214
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 18:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0621190073;
	Wed, 26 Jun 2024 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="e2BBrqOG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CDD18A93E
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719425078; cv=none; b=fcWtE1l6RPqep8HbbwtRjJFr8Uq62j4hVEpGfWh7NyaM3qNesUpHHPoL8DFvzw9gJaklXdOLOnZaMpdzgIhy5Tp6vWuS8UXYodqUDJvFooRNjb/cUfwrHouGl4omoFQBNuwb1K8NB+m9Ug3wXE/EJUkPIC1LW3U3fbSBSoylfaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719425078; c=relaxed/simple;
	bh=/dpduW/wE6hh7mfMO8FNQYjb2BLFoERD20G7Tp4SERA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stB2rYEfzoHNhlAaStHj3nU+vJrDHDBnNrX1NWeEgPdU18g5y7Y4NkOvON8VZwNSqnw+iEtofyWZJOQpA5yvRqsSV9WGyrP/xK8HIdydCuxB5Bjx8AxKMBWic2H8pJX/JvpgHnJWibIgNu588SbGbxFTNtPLWLyOpDyrnXOyXwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=e2BBrqOG; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79c0b1eb94dso111794285a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 11:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719425076; x=1720029876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aelliLONThBVLV6gF9spFPSnQEST2wClEncs8iGowwM=;
        b=e2BBrqOGyJsRs1XEk6TIcGJYaK30QODWJWaH88CRkhaAwxvDDYyIspIUrfBW2g5t4X
         CiFJw4ntb0qbKmlFdo46rh43JCEbzLEmUpFr+zu8fQaz1Ft2RvEa9TiWPbudlYBctXpu
         wPCpDsdZG80l6NETt2fa3w0HFQO33SBgH0wNnGe+JqN5PobZTEzbKgIfZ9ntquXMnYs9
         E6ZEKjgOizkAnpY7qFI3lkzFVRw9oeluYXAcysuMpEqwYEIg7sSMjiBjeF//6c48XOMF
         euxet87mOay08qwst6QDJvs8jP0ewRhHb5ZGHogS0kPCiwN9DsTGFDZf+6hgD7qihyxa
         zENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719425076; x=1720029876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aelliLONThBVLV6gF9spFPSnQEST2wClEncs8iGowwM=;
        b=RQ09NnX0LIApYCD8Pe3sz3RUMFNlXaTQd1mnUGAcRkZJqL4nFmzWqFBiPAh7+ypQ35
         SnBSJJzDnz6F7d11y83/6GiPgT8onlK0y1Up851jYsHjlmCyQEX9O1/JhgcbCw1DysTc
         U+VKo0a90OcYVxxWaZP3taMHvkrMvoV7wOay5tO/og80QiJRp+6H4D3I2+TLDPH42QCs
         rMVhB1iUaFm5T9aTjcpCJakHoYIWP6rbcln+E8GHi8vbZUdZ5k/yIfZzggiDX/xzOQQX
         /pbJJh4+Fp0WwEgAeEpJkmZgr/oia0usEBj1qs2lixOF3kQsMckJMaHBAXdYg/GPJeGW
         S7DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXtsZV2iN2lawag92mFgMbxikqpSyyVEqmadPkCz0nivvUzhiE0EBjhKz8W1gVVNXAU5rom4fwKb0JmkKUrw/NsMwtwdNbY7eIAEcr6A==
X-Gm-Message-State: AOJu0Yy0G2Dy6q1wzTPzsLnoEot47kKLm+Ni06sbQc/EVwT9ICcXmZeE
	++wnJyeFZDULnzzseFlmvFueV2UVnuGn9bVBNqOzbWU+GrtIZmNeGvF4cNvxe2o=
X-Google-Smtp-Source: AGHT+IGNXms9RbdWjD9JxYgjNqvnvgPSiXhZuapGkqutvE2Q7YM2CKv0tzCbIXLc1FLLyY/pDkPRpA==
X-Received: by 2002:a05:620a:25d0:b0:79b:f963:d25 with SMTP id af79cd13be357-79bf9630d29mr908482885a.75.1719425075867;
        Wed, 26 Jun 2024 11:04:35 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d58e24280sm24239885a.33.2024.06.26.11.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 11:04:35 -0700 (PDT)
Date: Wed, 26 Jun 2024 14:04:34 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com,
	kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] man-pages: add documentation for
 statmount/listmount
Message-ID: <20240626180434.GA3370416@perftesting>
References: <cover.1719417184.git.josef@toxicpanda.com>
 <t6z4z33wkaf2ufqzt4dtkpw2xdjrr67pm5p5leikj3uj3ahhkg@jzssz7gcv2h5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t6z4z33wkaf2ufqzt4dtkpw2xdjrr67pm5p5leikj3uj3ahhkg@jzssz7gcv2h5>

On Wed, Jun 26, 2024 at 07:02:26PM +0200, Alejandro Colomar wrote:
> Hi Josef,
> 
> On Wed, Jun 26, 2024 at 11:56:06AM GMT, Josef Bacik wrote:
> > V1: https://lore.kernel.org/linux-fsdevel/cover.1719341580.git.josef@toxicpanda.com/
> > 
> > v1->v2:
> > - Dropped the statx patch as Alejandro already took it (thanks!)
> > - Reworked everything to use semantic newlines
> > - Addressed all of the comments on the statmount.2 man page
> > 
> > I'm still unable to run anything other than make check, and if I do `make -t
> > lint-c-checkpatch` and then run make check lint build it fails almost
> > immediately on other unrelated things, so I think I'm too dumb to know how to
> > check these patches before I send them.  However I did my best to follow all of
> > the suggestions.  Thanks,
> 
> I'm interested in learning what problems contributors face, so please
> let me know those issues, if you don't mind.
> 
> You can
> 
> 	$ make lint build check -j8 -k
> 	$ make lint build check
> 
> to see the full list of failures.

I captured the output of

make lint build check -j8 -k > out.txt 2>&1

and pasted it here

https://paste.centos.org/view/ed3387a9

Clang messes up a bunch for a variety of different pages.

Also I did hit some mandoc warnings on this series, I'll post a v3 in a moment
with those things fixed.  Thanks,

Josef

