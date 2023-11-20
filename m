Return-Path: <linux-fsdevel+bounces-3264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF797F1E06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 21:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5853D1C21144
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 20:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1721B38DD7;
	Mon, 20 Nov 2023 20:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="XWaspkYY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28121C7
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 12:33:56 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6c39ad730aaso3862587b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 12:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1700512435; x=1701117235; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=evAEpm60eEP3dXV5IIqup+kGHQJCYdmk5kN5UrPqUqI=;
        b=XWaspkYYw44E33EzKaGnJUsIVM+Ss5R+yYkkZi0c9hwh1WD0cLRFNTtHoIbN9iv1Em
         6XBfwne5kehR8C8byBlNCobcSlPrqAmgG3OGf628BLtRoDNubaDRu7NyVC87/JFxVkOe
         sdxy8YKauDLBnAe1+J2REJsCWB1gNQJrRVieIX0RICJrEDA1tHgwBgHa+czTDzSz0lpE
         405jzexLvDQq7cwBVKzqRRr42f6mQzxeOij9p7nwS2sjxsh8dD2MjwMscWqK+2mcEcTn
         O3e3PjIDi6KdIS5gALCZ/YT3FsWhfv8mCu7NSAs3rnMAWuRp0KQggidp/k61xS0aWezK
         csTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700512435; x=1701117235;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evAEpm60eEP3dXV5IIqup+kGHQJCYdmk5kN5UrPqUqI=;
        b=Qtjhigs29jqxAM7nB1C0Iwu20a0h90FZzeZEjONewhQBDYCZwwQCbZnl60pYrW0TTB
         DgbHhgvkUygrTVSQgsx86k1GS6zuslB9h+8sb5orF0eV6PbvfN3juKs+s2cSLOI/H4ru
         K2faSZ1M3GzqyUP/wIJtF3XyM3hT2BnLlMye57OT6gAr4LKX6xqrTCsPxzoz4Se2E7Qp
         3WQqDfJabneig6xF1ZXO+oxPw7PEoibSglwCSy5C2qQDuRuu0k3vSH9jOdXHXeYUF83X
         9l0xW7Q6fMu4vWnr0sHfK58SlkSigeIJJx8UhYAd9XWualR1WjtQiusGgTo45fNehQai
         rS5w==
X-Gm-Message-State: AOJu0Yy2JK+5noSy8WvMgkDZupGNgRHddXJgfgowtcUxFXzqCwABukYS
	Opv9LLvENJOIBITghHpe6sJINQ==
X-Google-Smtp-Source: AGHT+IEUIW0UoDRHG7vGbEKmmcfumQAR5wXy6IpLvsSKoDwysXkoX+X9La6bv+9CGvmyGf8BTbi2pQ==
X-Received: by 2002:a05:6a20:c188:b0:187:9392:cfdd with SMTP id bg8-20020a056a20c18800b001879392cfddmr7866906pzb.24.1700512435511;
        Mon, 20 Nov 2023 12:33:55 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id k81-20020a628454000000b00688965c5227sm6783104pfd.120.2023.11.20.12.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 12:33:54 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1r5Axs-00FH1P-0e;
	Tue, 21 Nov 2023 07:33:52 +1100
Date: Tue, 21 Nov 2023 07:33:52 +1100
From: Dave Chinner <david@fromorbit.com>
To: Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH v9 0/3] [PATCH v9 0/3] Introduce provisioning primitives
Message-ID: <ZVvCsPelezZesshx@dread.disaster.area>
References: <20231110010139.3901150-1-sarthakkukreti@chromium.org>
 <ZU7RVKJIzm8ExGGH@dread.disaster.area>
 <CAG9=OMPFEV9He+ggq2mcLULnUZ2jm8fGU=4ca8kBoWtvqYcGVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG9=OMPFEV9He+ggq2mcLULnUZ2jm8fGU=4ca8kBoWtvqYcGVg@mail.gmail.com>

On Mon, Nov 13, 2023 at 01:26:51PM -0800, Sarthak Kukreti wrote:
> On Fri, Nov 10, 2023 at 4:56 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Thu, Nov 09, 2023 at 05:01:35PM -0800, Sarthak Kukreti wrote:
> > > Hi,
> > >
> > > This patch series is version 9 of the patch series to introduce
> > > block-level provisioning mechanism (original [1]), which is useful for
> > > provisioning space across thinly provisioned storage architectures (loop
> > > devices backed by sparse files, dm-thin devices, virtio-blk). This
> > > series has minimal changes over v8[2], with a couple of patches dropped
> > > (suggested by Dave).
> > >
> > > This patch series is rebased from the linux-dm/dm-6.5-provision-support
> > > [3] on to (a12deb44f973 Merge tag 'input-for-v6.7-rc0' ...). The final
> > > patch in the series is a blktest (suggested by Dave in 4) which was used
> > > to test out the provisioning flow for loop devices on sparse files on an
> > > ext4 filesystem.
> >
> > What happened to the XFS patch I sent to support provisioning for
> > fallocate() operations through XFS?
> >
> Apologies, I missed out on mentioning that the XFS patches work well
> with loop devices.
> 
> I might have misunderstood: were those patches only for sanity testing
> or would you prefer that I send those out as a part of this series? I
> can whip up a quick v10 if so!

I was implying that if you are going to be adding support to random
block devices for people to actually test out, then you should be
adding support to filesystems and writing new -fstests- to ensure
that loop devices are actually provisioning blocks at exactly the
locations that correspond to the physical file extents the
filesystem provisioned, too.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

