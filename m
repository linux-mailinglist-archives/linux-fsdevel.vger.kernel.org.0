Return-Path: <linux-fsdevel+bounces-39687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2CDA16F74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 16:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8D21881939
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 15:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE78F1E9912;
	Mon, 20 Jan 2025 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyntO9/F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5339E1E98F9;
	Mon, 20 Jan 2025 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737387743; cv=none; b=WT6yplfeo6RUl/SZUkhWbp0WLAk5C4BegKLc5ZSP8hAKj+3FeI6bnsSsYWyflabSFMj/Uwhu6rfD4/s7l7qxPIdfFAv2TkAtC8y2u6umZ6vA6NiP9SlNz0z+8rVbikdGUEWeG2T1oN1ln5NOXQOiJIfzeXV2lJIKcrDOIxMO9ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737387743; c=relaxed/simple;
	bh=h5vcF9u4Pm5YIKoTvW173EFr0OiBQpxft5MMxTIONa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfJr19GYRf0LIL18iq2IV6W/ThWAhj5F0hrC4LNv4eN3tNFScpuAFRM8zFVxyNvaNnnggSDn2BMdOZMTdIuCq3GXIpo/b828oJpnXGTlJZE6imKkTrMq8I5PY3hzsixNyj3pQ0rZ7yHjWPgTx1N8zlBg3PfQGwriQVwLh01m1iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyntO9/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBDFC4CEDD;
	Mon, 20 Jan 2025 15:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737387742;
	bh=h5vcF9u4Pm5YIKoTvW173EFr0OiBQpxft5MMxTIONa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uyntO9/FBj8NdNS7MHIo8Hi8Es+BbkDDlmmzY7PtcwOMHz+/8Af+JK+zTOvqJx+Eq
	 0O884wuKO2eZ9NsxPt0fSnghCg3ReY9fJp7MlNhcUAkL1AtrzwHPOr26K8su8bj6mm
	 y9FZOb2M7qtMFw7RMSGl+LKH6GjpIDDE4WFXx2DtKu3+RvvU9fNv9CDTPG270xdZEA
	 2owi6hkVYd3OqSXkDJT4g8fnCkSynY5JGkJ9vJGecwtwY2LNF0ppCHyl/Wfpaa656Y
	 MyEYisd677pTAq1scELjjzBV+l4bdTKYzWSiDq15X9CFNjIOCow7QNCMZWdjkbc3Rr
	 W00BdHb9cNMwQ==
Date: Mon, 20 Jan 2025 16:42:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>, 
	lsf-pc@lists.linux-foundation.org, 
	Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] time to reconsider tracepoints in the vfs?
Message-ID: <20250120-gemieden-miene-9b22201f9844@brauner>
References: <20250116124949.GA2446417@mit.edu>
 <Z4l3rb11fJqNravu@dread.disaster.area>
 <CAEf4Bzbe6vWS3wvmvTcCAQY6bZf2G-D6msgvwYHyWVg3HnMXSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbe6vWS3wvmvTcCAQY6bZf2G-D6msgvwYHyWVg3HnMXSg@mail.gmail.com>

>   - relative stability of tracepoints in terms of naming, semantics,
> arguments. While not stable APIs, tracepoints are "more stable" in
> practice due to more deliberate and strategic placement (usually), so
> they tend to get renamed or changed much less frequently.

I will support tracepoints in the VFS. It would be very useful to have
them.

But we will clearly document that we retain the right to change them at
any time. Tracepoints will not become a burden for refactorings or
rewrites that tend to happen not that infrequently.

