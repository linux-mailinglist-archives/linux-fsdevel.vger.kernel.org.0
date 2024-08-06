Return-Path: <linux-fsdevel+bounces-25093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83C5948D30
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 12:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165EA1C23676
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 10:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0CF1C0DD7;
	Tue,  6 Aug 2024 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdxnKc4B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470671BE852;
	Tue,  6 Aug 2024 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941408; cv=none; b=G8UAI+SPN30wQSrfF/HQSXgwkPDWl9j5lwXoDke7z3JLGagEW6UeAIAGn36fYAqUMJJe0uwlzrUeaKGxmmzfe9f63q4gebfR8ZtB9z2xKlOHbh5z/mFgJFdh1niXAcUUdrnzljqZP9li7+SX4SSx0xm5MOa6fo33zHrhNohJg7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941408; c=relaxed/simple;
	bh=cu1rKqjOR2dQYIpvhHz4ZVyuES7QVLkkGrlh5OBMdu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rku+vc9VnwXLmHYtik57CrPTWZHmydcvfkP56PsVS5UsYUVDJbX7Ep3YxtT5M7LUtDIgwseGe5Sr4O9CgVLfvrurmx82OF+Bk8bPAmA0UNwQDA+f8QdY9LQANEv+BnHl1NBmMeB2X1MynSkC83sX2lhrZEKZq6FhaNbhcF1Hsy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdxnKc4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D57C32786;
	Tue,  6 Aug 2024 10:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722941407;
	bh=cu1rKqjOR2dQYIpvhHz4ZVyuES7QVLkkGrlh5OBMdu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OdxnKc4Bl7AgqJDUhrZs3gScLhFJvaGyq6+X0cfsEGjGJNhGPHhrxMJrenggo6AVM
	 gnqfk1zA4iTM1/uKu4AbOZ8s/JrTqVntJQiYRA036pCid+H72xZ1ydJCTrDZDfSMMw
	 NF7jxY902F19WXvS5iultWveKAeRQ7sQVpADaG6XxWcBLQCSXOY/WOFUpDtZKRK6Nr
	 JsbxAJtWDRYbtJSYIieNWe0U6rkRf9dAZmGfJmbCu5EyrpoSRg1E3aez99FYPuQasy
	 GXRe/0Mjq3SpAlq7CSwtie0P5moQUYwsM6Lqb7z99lAj2STWGsN6ngzsHT6MorXpeV
	 JBwp/WHftCWRA==
Date: Tue, 6 Aug 2024 12:50:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: don't set SB_RDONLY after filesystem errors
Message-ID: <20240806-passt-weitgehend-6f1a0e7f3dbb@brauner>
References: <20240805201241.27286-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240805201241.27286-1-jack@suse.cz>

On Mon, Aug 05, 2024 at 10:12:41PM GMT, Jan Kara wrote:
> When the filesystem is mounted with errors=remount-ro, we were setting
> SB_RDONLY flag to stop all filesystem modifications. We knew this misses
> proper locking (sb->s_umount) and does not go through proper filesystem
> remount procedure but it has been the way this worked since early ext2
> days and it was good enough for catastrophic situation damage
> mitigation. Recently, syzbot has found a way (see link) to trigger
> warnings in filesystem freezing because the code got confused by
> SB_RDONLY changing under its hands. Since these days we set
> EXT4_FLAGS_SHUTDOWN on the superblock which is enough to stop all
> filesystem modifications, modifying SB_RDONLY shouldn't be needed. So
> stop doing that.
> 
> Link: https://lore.kernel.org/all/000000000000b90a8e061e21d12f@google.com
> Reported-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Thank you!
Reviewed-by: Christian Brauner <brauner@kernel.org>

