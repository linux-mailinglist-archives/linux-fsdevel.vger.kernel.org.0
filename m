Return-Path: <linux-fsdevel+bounces-10036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D56A18473C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 16:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3821F284DD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 15:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFF1146919;
	Fri,  2 Feb 2024 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZYzpF8+Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18D0179A5
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889350; cv=none; b=ib5GU4KOy3l9v1sZicCvaFz32JUz5ItETvbgj5GnzsLNTSOe1m/5uq02VDDuY193of9Y4G5+qi7km1bVfSMuCrVq8p8vIK9DGiG56cYjqbLwl7nljsSKLeHVm+UR2cDcxpl5W452bw6OIhC+qK3cwZ4sK0xsfYr2ph3d31qgMO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889350; c=relaxed/simple;
	bh=TVbzMpwRAFO6lwt5AX+qbLrLbE75MsS84/zt9kyfCUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5T7LbNKjEx+P7l5zPpdnMWvdzSBWvDHLljvexKxvu0eralD9ldTjuWikL9KxEvOQavNO0baS2yRy6/pl13olH0DAwAPdONvBiGWcJOpZvI8xlZdoCp0pgUJk3wUBTHoivbDvMTi1jPxlS+EAHYdxPrRW4Mz4NGYLcLHFP2N+C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ZYzpF8+Q; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d081a0e5feso13340151fa.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 07:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706889347; x=1707494147; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TVbzMpwRAFO6lwt5AX+qbLrLbE75MsS84/zt9kyfCUQ=;
        b=ZYzpF8+Q9eXROnR2Mj0FNNwrhFYId/B55v1XzaEWDn/cYDKgejslcsDV/ULV9VFD1/
         AiPpPnJIMdDxl+VNs68yp7QVPCsWvOiEMGvFj3E54b51UP66LcP1izF388nECyJX10Bd
         NI6xx/FrgN0N4AqqWvCl4nDf4VilC73aURBnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706889347; x=1707494147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVbzMpwRAFO6lwt5AX+qbLrLbE75MsS84/zt9kyfCUQ=;
        b=HRwdOqnhm5KRyOB9kdZNOgYcWDio3yuA2xpB2jGEINSSI7rm3PiY+YT3czYJV43R9+
         tU4d8l8suQqx2/hwGE23nfpVlyFA8H9MWlSAA+S7+6iTmQ+fvMUNu/41DmIgaFHL2oeG
         IK7Cgkpb7QDnkVNeZUf7JTRa8fxNOxrW/XfJcg55PIR/iwwCmfWCjg/dtkGniBWmHPbt
         ceu3bVMs1ttKc3EFkDbeVKsJK5QNcl4VXw9/7VvgPG8ixEuoRlhrITIidWWGWQEFYcs4
         ICidOertQOPuaPDhRRuIcqyP8Vx+uYFb5RRhIW699xThedog7cQSYjWVedLPydTOJcVc
         ipGg==
X-Gm-Message-State: AOJu0Yy0jnlqs0V0vgGHy9jUALGjOfYT9H8sQo4PH3KU6WLgNANf5M5S
	GLpvKP4lyM5682JplzaaVvaQ+PyujW4SrMQcvoxmOLXSMQfokdbnxDWAWCcJfFJu45+1pidx1an
	gu5WXmHtji3MKJta3uKKfTUURdLFEHkIdrGa7qfurKB3X+yG0
X-Google-Smtp-Source: AGHT+IFnN+y/nJcTahckutneKyDlz/OHiiZ+lWlS36H1Q8h+eMih71AMFenGl7byqtzCokEU0pddhZQuwVH+VSMqmjk=
X-Received: by 2002:a05:651c:2126:b0:2d0:7e15:8cd8 with SMTP id
 a38-20020a05651c212600b002d07e158cd8mr3285944ljq.49.1706889346644; Fri, 02
 Feb 2024 07:55:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230827.207552-1-bschubert@ddn.com> <20240131230827.207552-5-bschubert@ddn.com>
In-Reply-To: <20240131230827.207552-5-bschubert@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 2 Feb 2024 16:55:35 +0100
Message-ID: <CAJfpeguYDpLN9xPycd7UMwJfp-mctc38e4KFr2v_CvPSDayxEQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] fuse: prepare for failing open response
To: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, dsingh@ddn.com, 
	Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 00:09, Bernd Schubert <bschubert@ddn.com> wrote:
>
> From: Amir Goldstein <amir73il@gmail.com>
>
> In preparation for inode io modes, a server open response could fail
> due to conflicting inode io modes.
>
> Allow returning an error from fuse_finish_open() and handle the error in
> the callers. fuse_dir_open() can now call fuse_sync_release(), so handle
> the isdir case correctly.

Another question: will fuse_finish_open() fail for any reason other
than due to an interrupted wait?

If not, then maybe this belongs into a separate update which deals
with killability/interruptibility in a comprehensive way.

Thanks,
Miklos

