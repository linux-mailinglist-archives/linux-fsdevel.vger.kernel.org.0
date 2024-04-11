Return-Path: <linux-fsdevel+bounces-16670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 856948A13CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B728B1C20B7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 12:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E3514AD0D;
	Thu, 11 Apr 2024 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odMWvaUm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED850149C7E
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836871; cv=none; b=AUb7Sy8Cfi/O+sqMKblLmYPkyKOwC5MqtwwsSBjjv9F0msQFv19V35+Z+fSqsfgXHnIeGWuh/lLPdKUd1Duu2iQRD5LzAN1eEC0+uJgKxvw7Kvco6vHBDma+wF7JbiL5bGY705/QhoN+DZqR8tdD3SlvEdFUW1c5tvQQE5+GjmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836871; c=relaxed/simple;
	bh=OK0Q5XIKc7hW8WPiPsTR0D+lH/kbiJb+/Ts23jDqvsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKH+bD6F6i9kYxHUwISez+EE5ijGhbCTXaw1FJ+Ued8UDtfDpNsaEojI3kkhLC6CxMIB+5ZV7UtQPowUNTxsm9pU0D6Hro+hCRlEvpzrvKtEVOMZzsS3TfC+/lO5J6r/ZCeV/CzWtpvt6pFfrvqTYCCbIvyRN0U2JE3euCasZ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odMWvaUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8FCC433C7;
	Thu, 11 Apr 2024 12:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712836869;
	bh=OK0Q5XIKc7hW8WPiPsTR0D+lH/kbiJb+/Ts23jDqvsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=odMWvaUmm83MM2TYqMAE9dLMUr8J2e+KlOEYCy+MBUKWELYlgQSiRlynkG4ysqt0g
	 ALzn1ZMzsa7yJflurT++IQSFwrAwbaJ1VDSl7DLO+TTqbWG3B9GXwVlsjBRAMwttMO
	 1L76PR09kv5N/9zJ2oLS1VPcAockKUkCNUFltIafDmfco5bighdINmcvla/K063qSl
	 3zthgaOlpnT/5MNHNT9n+UPw6a0hC4NhGRqv3ztmszxQ3b2UfvLTO1JbILNgXNcqsC
	 E+TgaNTt9q2rRNwHXknL1W79FE3U6ne8/UEoWm4rrZKpVDcO1tWK/7rqs5eRY5e8C6
	 /EM2LASGnZnYw==
Date: Thu, 11 Apr 2024 14:01:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: compile out IS_SWAPFILE() on swapless configs
Message-ID: <20240411-goldbarren-angenehm-2239655a3f79@brauner>
References: <39a1479a-054a-4cb9-92c8-e9a2ed77c9f0@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39a1479a-054a-4cb9-92c8-e9a2ed77c9f0@p183>

On Wed, Apr 10, 2024 at 09:08:01PM +0300, Alexey Dobriyan wrote:

Fyi, this mail is empty for me. Not sure if this was an accident on your
end or something else.

