Return-Path: <linux-fsdevel+bounces-44580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA4EA6A786
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B02168D68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 13:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B722AE8E;
	Thu, 20 Mar 2025 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQ48u/6n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48203204C3A;
	Thu, 20 Mar 2025 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478445; cv=none; b=nQLx2eCto3F2Q7WSjW/P5unubjMQy1K4xd9NpnWTLcE1PpxWpsQMa08EitBHl28I2efRAbQBD7NALrshJvU08QbBT1d/E7N49lurH1aTKa5RocIUeXe+RV/f3qQc6aYHVevefGepdLXhT5LnZHWFO3v9iza82Eeaj+Z0yeJRgZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478445; c=relaxed/simple;
	bh=1I2vaiodf1jtoxc2ZmEXZDld7+thlT1yPlx1PTZJ5Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxvIEm9AhzFjBksyPQ/SDrQnCIk3khNg4uPJ+l/DkhooG9qF+XwFx8v2glekACiDLvWI30zr6vVCbgMsTrWDS54E9P9Qbi09KdYKCu1sXOH+q+JeJx4idqyCSc79wkZz3EyuICvhDWm7OBIYAPCQYZ7ABAWHUJtQ43y3Wtwsk5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQ48u/6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0D5C4CEDD;
	Thu, 20 Mar 2025 13:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742478444;
	bh=1I2vaiodf1jtoxc2ZmEXZDld7+thlT1yPlx1PTZJ5Kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pQ48u/6n9boML1dN80TRMxD5GeIRkcHa5XhmBGe4YDpQMGKTk+JvmACTfcWARJ3x+
	 4VaT+vKeGUjmXzaZKaBkdecu+xgRqjTsCiF4XB3I/JnnPM7B71S3lWM2N343pI3lPf
	 ZMiHuoVfU0qsy4p58QNxPceNIsxn0cuS7imCMq0QR9ZseQXhuUhH8AMSBW4dndZnHg
	 u3Wx3t2imPTz1kG0pyZCEWH/7mjRhYxx6dFAkZAwQyanA4iG/JZfx49fsrxfe/dK6x
	 xELilru2CfXkHf1opOBXPTUaJsl45XY63z6h7s9OlXfqJrM4GgAkx4z/h4BTLi7Hv8
	 gpBAat9885aMA==
Date: Thu, 20 Mar 2025 14:47:22 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org, david@fromorbit.com, 
	leon@kernel.org, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk, 
	joro@8bytes.org, brauner@kernel.org, hare@suse.de, willy@infradead.org, 
	djwong@kernel.org, john.g.garry@oracle.com, ritesh.list@gmail.com, 
	p.raghav@samsung.com, gost.dev@samsung.com, da.gomez@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
Message-ID: <ijpsvpc5xgd52r3uu3ibkjcyqzl6edke6fbotj7zf2wbw5vrqb@zzr274ln4tjd>
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>

On Thu, Mar 20, 2025 at 04:41:11AM +0100, Luis Chamberlain wrote:
> We've been constrained to a max single 512 KiB IO for a while now on x86_64.
> This is due to the number of DMA segments and the segment size. With LBS the
> segments can be much bigger without using huge pages, and so on a 64 KiB
> block size filesystem you can now see 2 MiB IOs when using buffered IO.

Actually up to 8 MiB I/O with 64k filesystem block size with buffered I/O as we
can describe up to 128 segments at 64k size.

Daniel

