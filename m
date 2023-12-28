Return-Path: <linux-fsdevel+bounces-6975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E099981F38B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 02:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D78C281F61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 01:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F98A10E6;
	Thu, 28 Dec 2023 01:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5va7tQ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6E1EA9;
	Thu, 28 Dec 2023 01:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A166EC433C8;
	Thu, 28 Dec 2023 01:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703725774;
	bh=VwYCv6gGPQ/YYWxYxWflWCiB/el4SBogmDzpvdiEhUA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I5va7tQ8MTVS+c7ooSC2tg96OtVZYUxvtVGElOdTMeSxywXvk1j79HPZZ9JkI1BjX
	 ylX7ra8UbxT0INljhybm6o24XgjCBukv7UfGitluAoPLDA0xrlgzZEmgCcZfKa1eRz
	 PD/A2WdS9ro00mPmD8spoFdQnsVvpyRaupvLmeaGh+toAYlRUAXvAB7GmAdxOM9qya
	 SkQz2vzdBrkbTU2UwfVPoS8qr9ext0gtrYhwUbUI86Wf0nelk1FBSF32bqYe2yfbAK
	 nrh8Ou9OjNJOFl9acbT+eRy3Lrws3DpGCSUTDnPkKDsFWhn3jwtRM+wFeN9ImOKMFR
	 T9jG00cu55QrQ==
Message-ID: <f1def3f6-e93d-46f0-b074-b459b6255b84@kernel.org>
Date: Thu, 28 Dec 2023 09:09:29 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: move release of block devices to
 after kill_block_super()
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Josef Bacik <josef@toxicpanda.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20231227171429.9223-1-ebiggers@kernel.org>
 <20231227171429.9223-2-ebiggers@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20231227171429.9223-2-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/12/28 1:14, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Call destroy_device_list() and free the f2fs_sb_info from
> kill_f2fs_super(), after the call to kill_block_super().  This is
> necessary to order it after the call to fscrypt_destroy_keyring() once
> generic_shutdown_super() starts calling fscrypt_destroy_keyring() just
> after calling ->put_super.  This is because fscrypt_destroy_keyring()
> may call into f2fs_get_devices() via the fscrypt_operations.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

