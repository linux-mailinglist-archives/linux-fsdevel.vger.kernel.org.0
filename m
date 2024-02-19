Return-Path: <linux-fsdevel+bounces-11971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD130859B19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 04:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368632812A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 03:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837D7523D;
	Mon, 19 Feb 2024 03:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="gvt1Zjfh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D195228
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 03:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708314158; cv=none; b=pKmSSf29xp61CeOl+t++bSTqosnbY0RYYHyRtURp8Fehpc6dDaycj5Acc7B4sNUH9NjBB5C2T+ZfhaNwOyVHxkQD45BgrNR6OFFlMXySCx4ggRrGrybIMC2eK0mwkYCYnDuC7zW1dBgjic8WAa3UaC68HBFWTWYnpmw1ce4Rir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708314158; c=relaxed/simple;
	bh=Hu/euHj5j899YVWzN9wf612S7R2Z3CPK4e4MYBKPJa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdKG7v12VAeOnMfN/2GDZKuO98UDG2J2pFK3mF8WKMhZKxsHkfbionED5DV3DW5s+mPccqTelbKPT4feZEjsl+s6+LssXyurVCSl/E4MJDkyE11ZQgUdq50WOCMuaqbYd7bqqhMeKn+cK5+pjv+0q52OmxEogb8wDXcS1Jzdp3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=gvt1Zjfh; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bbbc6bcc78so3071378b6e.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 19:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1708314155; x=1708918955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eyiPZACU0oUbgHtW/CjAbawigtEMb+yd9pHo7XpiTxc=;
        b=gvt1Zjfh/BkhzRyOHCVwRbDXyKyPx+drUq56KoK6c8jbXgHTXNF2lKIhVB37MxDOO5
         SYqzsFNAKJpbFU4S6V8EyBugOcgTPNhxYDTnTZoqFE413oLG+p+yYcXjhYjAhRy+2Gst
         sD2DkdsAzXVEtJYtQja0P6kI9fDGS7GXwydBvdZ/rM40b6ufDyiWw+Y3wdq70p3QxVjQ
         F9qzMt6zonQpccFi/1aOYwvR0wJeavHoGSAe1QtuxNiM3iGoukiZDEDIdpPALWkKeL10
         H3pBfTlvnYyG8lAVuFTTGO1v3y1ovgfxrTiTbzRZjZFfcfWkPvf+qHcIwkFBZ/eBbJr/
         Ah9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708314155; x=1708918955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyiPZACU0oUbgHtW/CjAbawigtEMb+yd9pHo7XpiTxc=;
        b=Z8Cla5oZX7KettIWAICJDNW1w85b6qrmuorfLlFwpCMKthtQ/Ko+8OCFImINBtOdkp
         5rE+1xNnTov2DzesqV7b3GTOOH1l1KqPdl63vAD7rxvb+oQBb1YrrJAlUAghdjAawdYn
         el3KbtQYDsxHP8q09iPyPKZS1qWUmTo6qaNqdi/hABRB7QVdRrF4x51zFy9NlqawQr52
         3Y+FivyP8p0TZmxF39WLNqXFwFdnFJvAivUyMTyKp2A1+C+Deh+KVjTam2ZluAKp/CoF
         d/99hDeSfFP2lTD5g8aC/+2irRoELqqeJSIq1IW6mExv6XbuHmlcDQvI/pstvPj7U7BU
         WaVA==
X-Forwarded-Encrypted: i=1; AJvYcCUGnzCDu7FeJnDR3fBoaAuEg24cj1bVjMAUl7PsWQr601s44q+G93sZJe4znOuXO55R29xV2ISl4gKkletaF8D49ppqmSjDxyNqApEz9g==
X-Gm-Message-State: AOJu0Ywqodl5dnD327K9wfXi9TWkGK9KFvTW6GUDn+CVMuC8zOzgUkbO
	zGMtthtsE52tfQ4whccmFp2MmEmwWd92oTlv46mY38JC53Ij2xeYGZqRBItdKvE=
X-Google-Smtp-Source: AGHT+IG247sHaGRl0dGx31RZj3qfKm4TNVdNxXI0dcCXMIdpylbZRR4lU0I0kGWWKmP/wgjk9l782Q==
X-Received: by 2002:a05:6808:1296:b0:3c0:4653:6e9e with SMTP id a22-20020a056808129600b003c046536e9emr13956348oiw.6.1708314155496;
        Sun, 18 Feb 2024 19:42:35 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id fb39-20020a056a002da700b006e44bce8318sm1695413pfb.124.2024.02.18.19.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 19:42:35 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rbuY4-008SAI-30;
	Mon, 19 Feb 2024 14:42:32 +1100
Date: Mon, 19 Feb 2024 14:42:32 +1100
From: Dave Chinner <david@fromorbit.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: fstests@vger.kernel.org, anand.jain@oracle.com, aalbersh@redhat.com,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	kdevops@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH 3/3] check: add --print-start-done to enhance watchdogs
Message-ID: <ZdLOKCYnM3XybqQp@dread.disaster.area>
References: <20240216181859.788521-1-mcgrof@kernel.org>
 <20240216181859.788521-4-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216181859.788521-4-mcgrof@kernel.org>

On Fri, Feb 16, 2024 at 10:18:59AM -0800, Luis Chamberlain wrote:
> fstests specific watchdogs want to know when the full test suite will
> start and end. Right now the kernel ring buffer can get augmented but we
> can't know for sure if it was due to a test or some odd hardware issue
> after fstests ran. This is specially true for systems left running tests in
> loops in automation where we are not running things ourselves but rather just
> get access to kernel logs, or for filesystem runner watdogs such as the one
> in kdevops [0]. It is also often not easy to determine for sure based on
> just logs when fstests check really has completed unless we have a
> matching log of who spawned that test runner. Although we could keep track of
> this ourselves by an annotation locally on the test runner, it is useful to
> have independent tools which are not attached to the process which spawned
> check to just peak into a system and verify the system's progress with
> fstests by just using the kernel log. Keeping this in the test target kernel
> ring buffer enables these use cases.
> 
> This is useful for example for filesyste checker specific watchdogs like the
> one in kdevops so that the watchdog knows when to start hunting for crashes
> based just on the kernel ring buffer, and so it also knows when the show is
> over.

Why can't the runner that requires timing information in the
kernel log just emit a message to the kernel log before it
runs check and again immediately after completion of the check
script?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

