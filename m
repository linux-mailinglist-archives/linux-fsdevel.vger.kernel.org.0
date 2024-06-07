Return-Path: <linux-fsdevel+bounces-21257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4654C90089D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C6D292CC4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3084B1DFC5;
	Fri,  7 Jun 2024 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUOXKxLO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9270B15B133
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773705; cv=none; b=n/o8SdOZkjKH/fwQAiRHXWPuFBBfjJUQxWlenINMMsEuQi0wtoQfsJ5vTgyZwocZysUCS/w4TUE1gua4smHlZLERFyjFNx7KAyC1BSsnpBVkuIB6KU05m223uXDBJG5gXIRjPiOyZ1LxttNIIP9c5xH07PMwyX7gMSqxVDfpzLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773705; c=relaxed/simple;
	bh=adRkVe51MSGSQ6b7AnoQH1OyR3S2BcAbFi07Xl/D2Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nl6fNpN4sm34LvEyiWYCllWB6MuH+t0qnvFMEZEORjK2U9/vitsZe1+l86LYPubEh4RKcTXvi22M2CVAAEmdrbkA4v53cBeyrwqEN15XaULpkrWsNlBHAe+2Ij+FGCFu/pLhk6EzXRsPdDxIaRjEsnlgE+feTK+Qo8SoI7x9um4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUOXKxLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9416C2BBFC;
	Fri,  7 Jun 2024 15:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717773705;
	bh=adRkVe51MSGSQ6b7AnoQH1OyR3S2BcAbFi07Xl/D2Pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RUOXKxLObU6BFnykyygLYfbz5xGStWCrh1FfNSDIG4q+FMMb51G/bWtHrP1BuRPPX
	 9eKSQx0KbN1NQf++tVkeVhTBNUG99Po4Ha/GzxWfdJnZTpo3K7Hq7Qa8tVv59+9kQj
	 aOOAVSRAJEZKG/LEi4zJQ8JZNpxUl4JfnNpteD+wXrwr1AFy4cCtckbwpPJg5ny1Ov
	 XEyU7p97753EIwirHo360qkluqWWOfJA5zD1F666j6ps8vo6xANiYpgtukdK4dk3tT
	 33QlLxjWSF2NfPng6dnHbjAOmnLReqzNtliquKZ+Ec5xMkluKELn8oZ6vlMmt1fuF6
	 dyIZTPJSb1elg==
Date: Fri, 7 Jun 2024 17:21:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 10/19] introduce "fd_pos" class
Message-ID: <20240607-tracht-apokalypse-5f5329b130f7@brauner>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
 <20240607015957.2372428-10-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240607015957.2372428-10-viro@zeniv.linux.org.uk>

On Fri, Jun 07, 2024 at 02:59:48AM +0100, Al Viro wrote:
> fdget_pos() for constructor, fdput_pos() for cleanup, users of
> fd..._pos() converted.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

