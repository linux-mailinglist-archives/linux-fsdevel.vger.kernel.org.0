Return-Path: <linux-fsdevel+bounces-15414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8850888E60E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 15:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9ABE1C2D878
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 14:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23D9152E09;
	Wed, 27 Mar 2024 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeI1DRl9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B904415251C;
	Wed, 27 Mar 2024 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711544175; cv=none; b=lziqLRHkzMO5a/41BZ8RfBZKyw1ZuoMfnVoKhR67CCoLMpbT+pgHg/xfaPc27R1BgdUXoTwvTx5cwsHvbtovVaVliEkE5QM9PVyE4Ax3gh/NiMoVTNfST8x50dN9KYoeCDHFi+E+FmS/vZvGWjPCg7Z8HtKZuqJflWz2U3eGx+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711544175; c=relaxed/simple;
	bh=t5Dr+QPEU1FaZbxI2VzHHPUV33oVM25Zuyjp8wRwBxQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=iFm3YA9kLj68XOWKZcMRSYtsJmWzLlxAfwsXERyDsxAoNx3HWu2zAjq//C8KpfGHKaIh/1yL63SZodp8dOBqiUC8HIuV0k4HF8w5tUBXDozTAVIEki1Pmua8JBKKALMd37+APWhJMOPMcYPPQ5aWVRnaqtddhkPWUmIU1B2XmeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeI1DRl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C93C43390;
	Wed, 27 Mar 2024 12:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711544174;
	bh=t5Dr+QPEU1FaZbxI2VzHHPUV33oVM25Zuyjp8wRwBxQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=PeI1DRl97jSBL5h+TjLof7OmsdrUn8XoRsGQVaXc1QrS2MsqMVnRRdmF+M5dmweaA
	 Cf4i01dUWOny6pJ6QuLijRvpE44xS0PcZc1e9PeN+WBhzhBO4xJy/Ts3k409QwdVEV
	 p+A11VpmypxO3Ps9Q8jXDfwY+GDNk4U7h2495MzupWAahXb3s6nMhf4xTbKbYBv9sH
	 Qg2EVim4HGea+Pk1qx3RaNxw1jAVCalYFQ1zjH9SvFpUEhLNt2Q6UwcJWGcqLuJGpO
	 jNEGpE3iLazGfTCtetqVqdY3FWUY6/vKk+gRsmlO3tArdLh8t7rKXHMt3Lo2FnfSbu
	 armFDkXpy3JVQ==
From: Kalle Valo <kvalo@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Jason Wang
 <jasowang@redhat.com>,  Xuan Zhuo <xuanzhuo@linux.alibaba.com>,  Richard
 Weinberger <richard@nod.at>,  Anton Ivanov
 <anton.ivanov@cambridgegreys.com>,  Johannes Berg
 <johannes@sipsolutions.net>,  Paolo Bonzini <pbonzini@redhat.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Jens Axboe <axboe@kernel.dk>,  Marcel
 Holtmann <marcel@holtmann.org>,  Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>,  Olivia Mackall <olivia@selenic.com>,  Herbert Xu
 <herbert@gondor.apana.org.au>,  Amit Shah <amit@kernel.org>,  Arnd
 Bergmann <arnd@arndb.de>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Gonglei <arei.gonglei@huawei.com>,  "David
 S. Miller" <davem@davemloft.net>,  Viresh Kumar <vireshk@kernel.org>,
  Linus Walleij <linus.walleij@linaro.org>,  Bartosz Golaszewski
 <brgl@bgdev.pl>,  David Airlie <airlied@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Gurchetan Singh <gurchetansingh@chromium.org>,
  Chia-I Wu <olvaffe@gmail.com>,  Jean-Philippe Brucker
 <jean-philippe@linaro.org>,  Joerg Roedel <joro@8bytes.org>,  Alexander
 Graf <graf@amazon.com>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Eric Van
 Hensbergen <ericvh@kernel.org>,  Latchesar Ionkov <lucho@ionkov.net>,
  Dominique Martinet <asmadeus@codewreck.org>,  Christian Schoenebeck
 <linux_oss@crudebyte.com>,  Stefano Garzarella <sgarzare@redhat.com>,  Dan
 Williams <dan.j.williams@intel.com>,  Vishal Verma
 <vishal.l.verma@intel.com>,  Dave Jiang <dave.jiang@intel.com>,  Ira Weiny
 <ira.weiny@intel.com>,  Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
  Bjorn Andersson <andersson@kernel.org>,  Mathieu Poirier
 <mathieu.poirier@linaro.org>,  "Martin K. Petersen"
 <martin.petersen@oracle.com>,  Vivek Goyal <vgoyal@redhat.com>,  Miklos
 Szeredi <miklos@szeredi.hu>,  Anton Yakovlev
 <anton.yakovlev@opensynergy.com>,  Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>,  virtualization@lists.linux.dev,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-um@lists.infradead.org,  linux-block@vger.kernel.org,
  linux-bluetooth@vger.kernel.org,  linux-crypto@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-gpio@vger.kernel.org,
  dri-devel@lists.freedesktop.org,  iommu@lists.linux.dev,
  netdev@vger.kernel.org,  v9fs@lists.linux.dev,  kvm@vger.kernel.org,
  linux-wireless@vger.kernel.org,  nvdimm@lists.linux.dev,
  linux-remoteproc@vger.kernel.org,  linux-scsi@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  alsa-devel@alsa-project.org,
  linux-sound@vger.kernel.org
Subject: Re: [PATCH 17/22] wireless: mac80211_hwsim: drop owner assignment
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
	<20240327-module-owner-virtio-v1-17-0feffab77d99@linaro.org>
Date: Wed, 27 Mar 2024 14:55:58 +0200
In-Reply-To: <20240327-module-owner-virtio-v1-17-0feffab77d99@linaro.org>
	(Krzysztof Kozlowski's message of "Wed, 27 Mar 2024 13:41:10 +0100")
Message-ID: <87plvf7s0x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> virtio core already sets the .owner, so driver does not need to.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

We use "wifi:" in the title, not "wireless:". It would be nice if you
can fix this during commit.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

