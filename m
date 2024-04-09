Return-Path: <linux-fsdevel+bounces-16423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709B189D550
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 11:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ACA72821BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 09:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453837F7C6;
	Tue,  9 Apr 2024 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hx2xnMbI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E517F7CC
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654480; cv=none; b=TCJ5Ou0b1+HhPtLT4DsHzACqKHq9HiYzcD1Ae60Uet8qQwRq1cUWw83X0svuRYg6nAS9N5THa+VZMQMoyqOnrMs6BY1DTgTIfoTnr6YPEcl48+C5U6NPrOfEj9REViWnPNfqoWrLZAhDRchttW54p8wZmNxcP/1+SUodJVHdAWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654480; c=relaxed/simple;
	bh=nTeCuYlbsPXYQ0dxnz61DVmoVKwT/Af0m9mhadHoWvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7Z90Uh3mFFkUBfN4BsX1cnisJ5GJ/osac5eMQkEHs8/BcoQ1jFBlPQLw3eHGikXkwpsrmuB21BsTZKiBPAPj07cDu8tGCGw2arjeVTTpybCghVaWLe/xQGWcz5FpVWAntFblMWNuOZrmSWV1ETxJH3xERNQcwwJRwbJ2Nc42gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hx2xnMbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F84C433C7;
	Tue,  9 Apr 2024 09:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712654480;
	bh=nTeCuYlbsPXYQ0dxnz61DVmoVKwT/Af0m9mhadHoWvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hx2xnMbIbWEURNxf3MQHDl/bZzn/f+hsds2tqVsDD7Z4pDZALKUNEmENX51CQ5Ppl
	 xqSZBfcHL2r6lA1F5e8WtTrgXn1gMeDtYClOGqTh4XlOQqs7SE4qaxbZD3c7IIjQkj
	 VI72oJGRvDK/EpoCGn7Q0bP8vQFC0W9CddJ55x10AWVOPL+DF1ZI0OcM5KXiM6Ba/A
	 L8Y4cv1hv4Nr4m86ZT2cv9p0pzSgDKDHPCu4LS5XLKy2UQYTfyhFGrU5OBSSwRkwhI
	 IXnhZVlk9sXC/UxQclAtPGc8QINVeZIgeeh/YVSg4Gg4gGgQCtwhYjVkTuDVaqOxmx
	 odLHpN2xWt6zA==
Date: Tue, 9 Apr 2024 11:21:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 1/6] close_on_exec(): pass files_struct instead of fdtable
Message-ID: <20240409-algebra-hauen-8a783916e5f1@brauner>
References: <20240406045622.GY538574@ZenIV>
 <20240406045707.GA1632446@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240406045707.GA1632446@ZenIV>

On Sat, Apr 06, 2024 at 05:57:07AM +0100, Al Viro wrote:
> both callers are happier that way...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

