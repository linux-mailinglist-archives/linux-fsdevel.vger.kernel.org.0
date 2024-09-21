Return-Path: <linux-fsdevel+bounces-29789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C3797DEA8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 21:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84DC71C20C5D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 19:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2254126BFB;
	Sat, 21 Sep 2024 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxlPos2w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AE92207A;
	Sat, 21 Sep 2024 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726948183; cv=none; b=tImnfZlfjNgZnvwwrIjzj3bfIK4/3h4T0I2HfFhYwIc7eiyhQ2YMFIcTP0FAqTO1+d+hWK9gbVPH1N019hv2ykqAUaYvCUWHTcdJnNyn2CLIL6LR3beMPO0oV8hvVvYSHFGGCWqUKAv+ggiR6v/HIsZmr9UUFFcb6WkB+lgeP1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726948183; c=relaxed/simple;
	bh=GyW5qcG4VHURUn7l9UbukhxZDZOp3cCpAGUdYYIDVAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0Dx6I9QZgHTx3SPgQcxWyx+lbjXi83h+eSpx61BMLX1Zfn+CEyQD7USIPYiBaLJfCB7iyQ7WYMzZdamPuTp9UHvcVrh+oU2IhjRGzf4rywvK/zos9/TdIIsLO4g59Bkf7OL02u/SMLDt0DoZ3MMWqkAXn/bF1YD5MZjiZpCHqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxlPos2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A625AC4CEC2;
	Sat, 21 Sep 2024 19:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726948182;
	bh=GyW5qcG4VHURUn7l9UbukhxZDZOp3cCpAGUdYYIDVAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uxlPos2w5FHgKlymMk0wB47bTleRHxvbVqulFxoLoRk6zM0gaolbwyqBdeVVr2Khw
	 6q8h3FlKZqQcAtXCinhWaCqbqPn5wkI27oC47zTyPWp4t0ylpFbQkBNCXWaDPP5M88
	 Bnb1eeOVMubmY0TDoWp8AAQst71suk/zuUaMNOylGnU8KChb262+B1owZZKzUAO7t6
	 UD8jltyfj3qp9N3j1z1DnYxYTY3vY+Olx5uWXflQ5GOdmekcWxcfHr8f6h9pbiZNpL
	 T6zF9KMx6Ic9qSprx1T3x3ETlLQktjj0IkGfudP+gO3LGpNiPVDX/3RkBWXtzyhFbS
	 VsfrbfucOkQBg==
Date: Sat, 21 Sep 2024 12:49:39 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: "Gaurav Kashyap (QUIC)" <quic_gaurkash@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Asutosh Das <quic_asutoshd@quicinc.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"bartosz.golaszewski" <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v6 09/17] soc: qcom: ice: add HWKM support to the ICE
 driver
Message-ID: <20240921194939.GB2187@quark.localdomain>
References: <7uoq72bpiqmo2olwpnudpv3gtcowpnd6jrifff34ubmfpijgc6@k6rmnalu5z4o>
 <66953e65-2468-43b8-9ccf-54671613c4ab@linaro.org>
 <ivibs6qqxhbikaevys3iga7s73xq6dzq3u43gwjri3lozkrblx@jxlmwe5wiq7e>
 <98cc8d71d5d9476297a54774c382030d@quicinc.com>
 <CAA8EJpp_HY+YmMCRwdteeAHnSHtjuHb=nFar60O_PwLwjk0mNA@mail.gmail.com>
 <9bd0c9356e2b471385bcb2780ff2425b@quicinc.com>
 <20240912231735.GA2211970@google.com>
 <CAA8EJpq3sjfB0BsJTs3_r_ZFzhrrpy-A=9Dx9ks2KrDNYCntdg@mail.gmail.com>
 <20240913045716.GA2292625@google.com>
 <egtwyk2rp3mtnw2ry6npq5xjfhjvtnymbxy66zevtdi7yvaav4@gcnmrmtqro4b>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <egtwyk2rp3mtnw2ry6npq5xjfhjvtnymbxy66zevtdi7yvaav4@gcnmrmtqro4b>

Hi Dmitry,

On Fri, Sep 13, 2024 at 03:21:07PM +0300, Dmitry Baryshkov wrote:
> > > > > > > Once ICE has moved to a HWKM mode, the firmware key programming
> > > > > > currently does not support raw keys.
> > > > > > > This support is being added for the next Qualcomm chipset in Trustzone to
> > > > > > support both at he same time, but that will take another year or two to hit
> > > > > > the market.
> > > > > > > Until that time, due to TZ (firmware) limitations , the driver can only
> > > > > > support one or the other.
> > > > > > >
> > > > > > > We also cannot keep moving ICE modes, due to the HWKM enablement
> > > > > > being a one-time configurable value at boot.
> > > > > >
> > > > > > So the init of HWKM should be delayed until the point where the user tells if
> > > > > > HWKM or raw keys should be used.
> > > > >
> > > > > Ack.
> > > > > I'll work with Bartosz to look into moving to HWKM mode only during the first key program request
> > > > >
> > > >
> > > > That would mean the driver would have to initially advertise support for both
> > > > HW-wrapped keys and raw keys, and then it would revoke the support for one of
> > > > them later (due to the other one being used).  However, runtime revocation of
> > > > crypto capabilities is not supported by the blk-crypto framework
> > > > (Documentation/block/inline-encryption.rst), and there is no clear path to
> > > > adding such support.  Upper layers may have already checked the crypto
> > > > capabilities and decided to use them.  It's too late to find out that the
> > > > support was revoked in the middle of an I/O request.  Upper layer code
> > > > (blk-crypto, fscrypt, etc.) is not prepared for this.  And even if it was, the
> > > > best it could do is cleanly fail the I/O, which is too late as e.g. it may
> > > > happen during background writeback and cause user data to be thrown away.
> > > 
> > > Can we check crypto capabilities when the user sets the key?
> > 
> > I think you mean when a key is programmed into a keyslot?  That happens during
> > I/O, which is too late as I've explained above.
> > 
> > > Compare this to the actual HSM used to secure communication or
> > > storage. It has certain capabilities, which can be enumerated, etc.
> > > But then at the time the user sets the key it is perfectly normal to
> > > return an error because HSM is out of resources. It might even have
> > > spare key slots, but it might be not enough to be able to program the
> > > required key (as a really crazy example, consider the HSM having at
> > > this time a single spare DES key slot, while the user wants to program
> > > 3DES key).
> > 
> > That isn't how the kernel handles inline encryption keyslots.  They are only
> > programmed as needed for I/O.  If they are all in-use by pending I/O requests,
> > then the kernel waits for an I/O request to finish and reprograms the keyslot it
> > was using.  There is never an error reported due to lack of keyslots.
> 
> Does that mean that the I/O can be outstanding for the very long period
> of time? Or that if the ICE hardware has just a single keyslot, but
> there are two concurrent I/O processes using two different keys, the
> framework will be constantly swapping the keys programmed to the HW?

Yes for both.  Of course, system designers are supposed to put in enough
keyslots for this to not be much of a problem.

So, the "wait for a keyslot" logic in the block layer is necessary in general so
that applications don't unnecessarily get I/O errors.  But in a properly tuned
system this logic should be rarely executed.

And in cases where the keyslots really are a bottleneck, users can of course
just use software encryption instead.

Note that the number of keyslots is reported in sysfs.

> I think it might be prefereable for the drivers and the framework to
> support "preprogramming" of the keys, when the key is programmed to the
> hardware when it is set by the user.

This doesn't sound particularly useful.  If there are always enough keyslots,
then keyslots never get evicted and there is no advantage to this.  If there are
*not* always enough keyslots, then it's sometimes necessary to evict keyslots,
so it would not be desirable to have them permanently reserved.

It could make sense to have some sort of hints mechanism, where frequently-used
keys can be marked as high-priority to keep programmed in a keyslot.  I don't
see much of a need for this though, given that the eviction policy is already
LRU, so it already prefers to keep frequently-used keys in a keyslot.

> Another option might be to let the drivers validate the keys being set
> by userspace. This way in our case the driver might report that it
> supports both raw and wrapped keys, but start rejecting the keys once
> it gets notified that the user has programmed other kind of keys. This
> way key setup can fail, but the actual I/O can not. WDYT?

Well, that has the same effect as the crypto capabilities check which is already
done.  The problem is that your proposal effectively revokes a capability, and
that is racy.

- Eric

