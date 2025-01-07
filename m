Return-Path: <linux-fsdevel+bounces-38579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8ECA0438D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 16:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067D5164BC4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 15:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6801F2C5A;
	Tue,  7 Jan 2025 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6DQqL3g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B361E515;
	Tue,  7 Jan 2025 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262039; cv=none; b=iBwbs/p+FImhjFnlDNEKeZZWr8gAlf37y+RXpPkCx6ZjWkcLWLwiVPOEJI6SYIY/P0hxpn9j09T9xAxt4xuetfbMaWJilxS3LHpeFimywNAriNPtkCgqw5befiYpDSVrRpXcVEtT/Mcur+eG8rh0QevxSqxxt6ef+kX8FA924Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262039; c=relaxed/simple;
	bh=YmwVpJQTHntCxgaoyBIkua2BanDtkp07TCVkCBgonFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlhRtGeTH32PJfqGYdqxuR9i1Ua2tSbSuil2kTPwctNYA8qXjo4Krfykl9UdA6O+RDrfl9MusSJM/UF7QqQwWM9hNtGX0SoGVDsxnspV3ZZyfb/oTWemWNvC7mZyIcu0rILYT4kGIB3WYOwrfJ6mMAYPl10YaZpa0lvsI4NkGM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6DQqL3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3FAC4CED6;
	Tue,  7 Jan 2025 15:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736262038;
	bh=YmwVpJQTHntCxgaoyBIkua2BanDtkp07TCVkCBgonFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j6DQqL3gL1fXbJj4DsqS+7XfQrtdEITSThiJefggbFFosWobsN3ECtTTuLp8HlGeL
	 0a4jQreHOk4Zg5ufJR73T/0qbwXW3Y19bp8ueo+rJhrXv/hBVEZkPBtXTHlvNKv01U
	 XQQrmXFGzgUH8kq1qUMuNtELK8b6b3/s/9m2dZ/xAaKYXDgs86bMaKMAF+aIecf645
	 5np58tA0rAaBD4yJxYAhmw9q7Zp/gxIJYv4D5rBU+RahSkRcBhP6H6M/drSps2yaGB
	 ezQIMvE6uqn1f1lOuRV89pujcJO0/kYwPEAu4JLHTxujgipSlBXFjMK+8aNDZopGgk
	 Ex1XiWnXd+VdQ==
Date: Tue, 7 Jan 2025 16:00:34 +0100
From: Christian Brauner <brauner@kernel.org>
To: Daniel Vacek <neelx@suse.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-fsdevel@vger.kernel.org, 
	linux-btrfs <linux-btrfs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: mnt_list corruption triggered during btrfs/326
Message-ID: <20250107-infusion-aushilfen-0110ff7c9e61@brauner>
References: <ec6784ed-8722-4695-980a-4400d4e7bd1a@gmx.com>
 <324cf712-7a7e-455b-b203-e221cb1ed542@gmx.com>
 <20250104-gockel-zeitdokument-59fe0ff5b509@brauner>
 <CAPjX3FepKnPQhhUpgaqFbj_W54WwcxBa++-C1AVd1GDi98-t4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPjX3FepKnPQhhUpgaqFbj_W54WwcxBa++-C1AVd1GDi98-t4g@mail.gmail.com>

> > Can you please try and reproduce this with
> > commit 211364bef4301838b2e1 ("fs: kill MNT_ONRB")
> 
> This patch should indirectly address both errors but it does not
> explain why the flag is sometimes missing.

Yeah, I'm well aware that's why I didn't fast-track it.
I just didn't have the time to think about this yet.

