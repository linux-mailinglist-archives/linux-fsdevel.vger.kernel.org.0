Return-Path: <linux-fsdevel+bounces-39688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63FAA16F77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 16:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21B73A1A12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DDF1E9907;
	Mon, 20 Jan 2025 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vxfh0s7z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF041B4F02;
	Mon, 20 Jan 2025 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737387816; cv=none; b=DXBrnHDBqdmJagH2tS5yLW/4e0EWw0P3ehbNpomvOmLXO05n6FrjYav33dgg9YzlRhUIw5Kck16sRy6tUMpCKeOg5NNlc6c5YFNz33NabWEhR0aJtb89wykkxh1xK2ABuX/2DZ7V2xXvhx+AXHL5IehY5c1oYY63qyPmmPl4sDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737387816; c=relaxed/simple;
	bh=ihaxp0Cfcxv1a4lLZlwqJuwULPbjAQo0kojgumn31Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVPRYWl/IBntwLOkF61ceiKv+mAemL5IMoQgp08JFcGL67gLhYakO+jT6ll5NH3N7fbkRnZUPtGPtISx/idAVs4vN9Tkp+kPQcJt65ZQzJKscoUt0uffchH/VRv0RzkJVrgPkT48zxsL/9d2vGe+ijAXhmodhGqbqhL2gj3UbhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vxfh0s7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1144CC4CEDD;
	Mon, 20 Jan 2025 15:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737387815;
	bh=ihaxp0Cfcxv1a4lLZlwqJuwULPbjAQo0kojgumn31Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vxfh0s7z2dFiOzRpNNIowXJxK4ZiMleclTUk36vLUpDIwNGBXxCzJNVakSWj1+eU6
	 GODlCC5U5TZDXFaknJIGYYP3xkiiy8Eer0HdN4cl0pih5wcC7EkBxat87kJV47h6oZ
	 hAfli2VuAyzgsjni2zOao2MD5Yq25Ad8oNTFtwzAwDpOWFQNk7shCbwreouiNZwRsz
	 18Dwj4BY3p2tHYpLO0ATp550kFBPi2C3J9p2OhyPch4LnPfyCQ517oODkJAYXxArdo
	 fJUC1VoW4hJc54i8KBatNwRukm3e9yVTAB7NXZgbezrNDK7g0NtWavmST4CTgQbrLe
	 wLtk4ZvySs09w==
Date: Mon, 20 Jan 2025 16:43:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Theodore Ts'o <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org, 
	Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] time to reconsider tracepoints in
 the vfs?
Message-ID: <20250120-heilkraft-unzufrieden-a342c84a4174@brauner>
References: <20250116124949.GA2446417@mit.edu>
 <t46oippyv2ngyndiprssjxnw3s76gd47qt2djruonbaxjypwjn@epxwtyrqjdya>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <t46oippyv2ngyndiprssjxnw3s76gd47qt2djruonbaxjypwjn@epxwtyrqjdya>

> that it's not a big deal.  I'm watching with a bit of concern developments
> like BTF which try to provide some illusion of stability where there isn't
> much of it. So some tool could spread wide enough without getting regularly
> broken that breaking it will become a problem. But that is not really the
> topic of this discussion.

We've stated over and over and will document that we give no stability
guarantees in that regard.

