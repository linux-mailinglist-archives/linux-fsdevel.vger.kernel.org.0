Return-Path: <linux-fsdevel+bounces-22344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA58A916883
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CD11C228C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 13:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0DC158D75;
	Tue, 25 Jun 2024 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="YN2Ynl4H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D0A1DFC5
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320412; cv=none; b=lUFklR7UT6/la8quDPSDw2ZL0l+Oi5nMdgaOyWwdIhaXr3zUEg3HsIPh7Iab+wzyBeVwYBjx3fKXdOfZELuxiPpQIPTDjk6D/S9WHoS1vOOgV9dsbDfK4Gh8ZDviri/dFccLekp7ld3+/f2D5mDOVzzBX0Mx4kjoojku+1qy09A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320412; c=relaxed/simple;
	bh=2lQRlRzKgoSP4iqqMxC62izbdnVoIyNtxogoKKH54rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCDHW+E/cyx7Vi4NEnRB/MAeTUdgc+Z4FzHDlKjAYFW1Okjlq0fL63HnHQQ3EqVXURWxgq3J5Q5J1ctFLVauSnA9uqPNMsvpn74HzBrkDl9Rc6/3LL1S+7jZvwx5JPSczSBdJeVViEc7JNsyyJT98bf90cEKFf9Mom4qqnfSv/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=YN2Ynl4H; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7955841fddaso459822385a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 06:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719320410; x=1719925210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m1UtYMBxYjD1i/t4h2k//koZngnXIsZW2dtVRID4jgs=;
        b=YN2Ynl4H7qvklGsoEuveOY+xoyi+75iSkEtxkvwggvWZd/ylEHWCX/6CwT47SMWQY0
         AKdcJGyWoFkK0RG64vEE6aVceeG9N//BWZblhcIxodfqj/Jy/8fM6yMnC3ZRvDzPjeMG
         daAQr4qcCxuIIvExrLlNX6w1NYdpobPZDS55Caq3eWvAE1Sn9CdYw1RC+WHwp+ThD9tJ
         VJl5Nrso/61a3SoBO741ts6yqyxNae+KM8TzFOqcFq+YPGq+mhftEbGpzumYF3my+235
         OZBRfkHL6Q4OZBxY7Jr0+JvKYO38EDYqWvXNYRzW9xzsKDPIE1cDZ4I988DWLM41yWP0
         vq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719320410; x=1719925210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1UtYMBxYjD1i/t4h2k//koZngnXIsZW2dtVRID4jgs=;
        b=NMgVYlqBsmaZ4sOB/pWmfKPMabisNEgP5cGIQHQoYGRVKbmWs5Ysv5HB9bqYy1ZCYl
         +wAOteT5pi/VQ2IGx4oCpaiAvWRN3OwuP1BuEi+nDsR2JWYG2DGIjGDjxyy7rOl9CaWM
         oNiBKJBYZ6nxU/te4OwlxDcSKTE/JPHzhCQ4kZsLu889DkJQ1+qzWXYVXJlNmZa6C9+C
         JpB3yUYoxdQY8j/C5m9VVSyXCtQDJCBQX0KrYBxiRtRIi98m/VlC6Fvms7+cfi2z5vxg
         FCvvYTMXQ26VO5e0+mKP/HfUQ/a05iU4TGmZpHF2Jqx0RIWmc71wGVle89jNL5nIc2An
         fhLg==
X-Gm-Message-State: AOJu0YxRNMA+kKFD6iC9cbuKeghgoNd3zC98MfuEshHrmd9D4nZ5fYtJ
	/HalhmUSf04FJJCGwwKO8gZ59ufolPWtE5RxpvgyhUVezP0GE05R2t4pItRi66M=
X-Google-Smtp-Source: AGHT+IHizzuBvUT4owqUntIO+rvkxYUKqaRhsajiUnpyq/KNp1jR93jJvqHDDxwpmCgHli/qtKYTWQ==
X-Received: by 2002:a05:620a:27cf:b0:79b:b83d:a123 with SMTP id af79cd13be357-79bfd68373bmr565154985a.30.1719320409891;
        Tue, 25 Jun 2024 06:00:09 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce8b366esm404623385a.32.2024.06.25.06.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 06:00:09 -0700 (PDT)
Date: Tue, 25 Jun 2024 09:00:08 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/4] Add the ability to query mount options in statmount
Message-ID: <20240625130008.GA2945924@perftesting>
References: <cover.1719257716.git.josef@toxicpanda.com>
 <20240625-tragbar-sitzgelegenheit-48f310320058@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625-tragbar-sitzgelegenheit-48f310320058@brauner>

On Tue, Jun 25, 2024 at 12:42:14PM +0200, Christian Brauner wrote:
> On Mon, Jun 24, 2024 at 03:40:49PM GMT, Josef Bacik wrote:
> > Hello,
> > 
> > Currently if you want to get mount options for a mount and you're using
> > statmount(), you still have to open /proc/mounts to parse the mount options.
> > statmount() does have the ability to store an arbitrary string however,
> > additionally the way we do that is with a seq_file, which is also how we use
> > ->show_options for the individual file systems.
> > 
> > Extent statmount() to have a flag for fetching the mount options of a mount.
> > This allows users to not have to parse /proc mount for anything related to a
> > mount.  I've extended the existing statmount() test to validate this feature
> > works as expected.  As you can tell from the ridiculous amount of silly string
> > parsing, this is a huge win for users and climate change as we will no longer
> > have to waste several cycles parsing strings anymore.
> > 
> > This is based on my branch that extends listmount/statmount to walk into foreign
> > namespaces.  Below are links to that posting, that branch, and this branch to
> > make it easier to review.
> 
> So I was very hesitant to do it this way because I feel this is pretty
> ugly dumping mount options like that but Karel and others have the same
> use-case that they want to retrieve it all via statmount() (or another
> ID-based system call) so I guess I'll live with this. But note that this
> will be a fairly ugly interface at times. For example, mounting overlayfs with
> 500 lower layers then what one gets is:
> 

Yeah this isn't awesome, but neither is the string parsing code I have in the
selftest to validate this feature.

I chose this approach because 1) it's simple and I'm lazy, and 2) I think
anything else becomes a lot more complicated and more work than what people
actually want.

I imagine what would be ideal would be some sort of mount option iterator
mechanism.  Either we shoe-horn it into statmount() or we add a
listmountoptions() syscall, and we then get back a list of mount options
individually laid out.  This means we now have to keep track of where we are in
our mount option traversal, and change all the ->show_options callbacks to
handle this new iter thing.

We could go this way I suppose, but again this is a lot of work, and honestly I
just want to log mount options into some database so I can go looking for people
doing weird shit on my giant fleet of machines/containers.  Would the iter thing
make the overlayfs thing better?  Yeah for sure.  Do we care?  I don't think so,
we just want all the options, and we can all strsep/strtok with a comma.
Thanks,

Josef

