Return-Path: <linux-fsdevel+bounces-46007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B5FA81369
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 19:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D0A8A0AC9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 17:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35102236A9F;
	Tue,  8 Apr 2025 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpWn1kEf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA6314AD2D;
	Tue,  8 Apr 2025 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744132860; cv=none; b=IclEWsqoBw2mHCOGMxsJrb0gHUAc4Li0ksYPkx+GgbopX106uX4dVsHvY0mvtHHn9QP8ex+P4BkqosZsTX9TtHXtCKFKcJ7XbUwV0Lbx8mMZo2JsPVV1p7jFhDaZ6FiKqaitpgrqc1Nemcd5hJZftHf+y1cN7OOgFhhKQl5ebVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744132860; c=relaxed/simple;
	bh=AhmY3AwCRb8L8dK1nHZmSaNFTtro4q7ZCQdl7BcxAqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLCszXZUUlCBrOJzlv9H0z9O4sdUQz4qVr26qZeviv5PCoM/C4c0Q8KS5fb2ItXL/Ba408rx7veSEOcfGtN6hyxvNoJbvBgjnpFpB3dAnv61um6IQr4d5C+BgPqRM9lDMvBX1i7GzLq8k60DGPY8qvIoCmCD16fp1aJeZxYJgII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpWn1kEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889BFC4CEE5;
	Tue,  8 Apr 2025 17:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744132860;
	bh=AhmY3AwCRb8L8dK1nHZmSaNFTtro4q7ZCQdl7BcxAqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DpWn1kEf4+B2DwyS5jdg5hJk2rzyTf7Y6LDO+EvaBFQMerLXn+1Ef1XI+RB8az0Kl
	 enJFAVNo2ctVoS8Bm7AGKywiyNNZYkbiWTMk5m3kFbvcZhOBNcThys2oSS1eV8Xp0T
	 WVjsLTibZKVMWzqaVUkfUEZpiG01lC6LXlQLMgQC7/mIIhWRitEAS0AhIgyZlA7MNs
	 UgRHwRXGrDC1f9cQ/kIBiNjpKC0ka+KE9cHSd4G4bKG2yie6Irq4/J44gKGPraDd/o
	 8oD5lIBxF9N91Lt6L3mwSmkjr7uOfpTFbqosfz2zsmVHmTn+/MloNinQZvgSoF8IuQ
	 ZeyOCWYrYihow==
Date: Tue, 8 Apr 2025 10:20:58 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	jack@suse.cz, rafael@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	hch@infradead.org, david@fromorbit.com, djwong@kernel.org,
	pavel@kernel.org, peterz@infradead.org, mingo@redhat.com,
	will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 0/6] power: wire-up filesystem freeze/thaw with
 suspend/resume
Message-ID: <Z_Va-ilQPuysfdhS@bombadil.infradead.org>
References: <20250331-work-freeze-v1-0-6dfbe8253b9f@kernel.org>
 <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
 <ddee7c1ce2d1ff1a8ced6e9b6ac707250f70e68b.camel@HansenPartnership.com>
 <20250402-radstand-neufahrzeuge-198b40c2d073@brauner>
 <2d698820ebd2e82abe8551425d82e9c387aefd66.camel@HansenPartnership.com>
 <Z_VYZAgHNGEqF7ZB@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_VYZAgHNGEqF7ZB@bombadil.infradead.org>

And in case its useful, to test this on a VM you'll need on libvirt:

</os>                                                                                                                                                                                                                                      
<pm>                                                                                                                                                                                                                                     
<suspend-to-mem enabled='yes'/>                                                                                                                                                                                                          
<suspend-to-disk enabled='yes'/>                                                                                                                                                                                                         
</pm>   

The litmus test which used to stall without ever returning was:

while true; do                                                                                                                                                                                                                               
dd if=/dev/zero of=/path/to/xfs/foo bs=1M count=1024 &> /dev/null
done 

To suspend you can use one of these two:

echo mem > /sys/power/state
systemctl suspend

Verify you can resume from suspend:
virsh qemu-monitor-command guest_foo 'query-current-machine'
{"return":{"wakeup-suspend-support":true},"id":"libvirt-415"}

To resume the guest:

virsh dompmwakeup guest_foo

  Luis

