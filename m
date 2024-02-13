Return-Path: <linux-fsdevel+bounces-11485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EA2853EF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE6A2883B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB526280B;
	Tue, 13 Feb 2024 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="bJZB4ozt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF026169F
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864310; cv=none; b=qRo/XHwcsJpemxlvqgI/708AuI22XNs/aOSbdfHUg98tsBkBTk63CPdxog1Xzy5MpKslGXITeQsEKtOIyUzk16+4mrp9k7FXPxkucF60hVC4rooyWMmNG3Iztlitj/C0vvO3PxOJ2tFNwlEMA4LHxVRF6cYWkOZWGmt/ZIstzIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864310; c=relaxed/simple;
	bh=HBYciFeZBNHgQsYnR6EeVMEsINZyKu5uLE+AmLv/jjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+TsXW4uUdKoSjmp2mes0lNbvGaGukI5juEceQfCdpwi9c5sncKZ7zghusCeV5GzDlbV6lcTJvZGyzqt3UXh0ZrbgqQDsKQdiWb8opHv8hw36TlrqO/qxGspTkwfxL3oDg0gCRROuAohldNQGC+VsLTpMgCnQ9MaXcv5zHNrkNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=bJZB4ozt; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so4049675b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 14:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707864307; x=1708469107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VSX+f82UonQUib7g2mNUoZMszrXmjLE1tVvT69rZd4k=;
        b=bJZB4oztXzNtD0mM4yzJN3tF3CC56qYCy35KlYe/cocJWq58cE/fjW+tImjoZrNl8O
         IJEUQSg+zmgovotdGcG/Awk7mY/gjCvmW98h4szuVuLLOpCNMMIupmbFyDc9dDqMqbmI
         SGlIFKDJTevEuvXlX3Xe2F/S2FYsKN4ZkP9ORmgdEwmjkcZHFuwOyv5OiGBkeI2jyFjD
         GeIbzt8NiYbHc+krnkK5JQ6AcZUR1uSp8zAVAb5mKn/qfD0pC1I6hp5mjqNczFYLg8+d
         gAxg9GoRn+Q5wLm5J1hSZ+FuX+afKO9tlLY4z7C7/lG5NsDV0XFvGtFSYRg3E0yqhIDI
         e56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707864307; x=1708469107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSX+f82UonQUib7g2mNUoZMszrXmjLE1tVvT69rZd4k=;
        b=S+3glsXYZPopLdzcYWlVD0GvdOsc44zqW6TKJCiswwUVsflKD92lRpZm7qnFkSpAz5
         Q0OBob2zwbuNLBbK1zZmk+ZjFuFMb10MCON7ko+tQRYodyZpK2jvKpb+15SoSeLIjIEg
         NCPMy/msx23GyAURum16956wHIh0+jCVnyZU8394FlPQcliGrQ+rHcL1g++k4VWBViH3
         7Q3NqVR8xFOOK8hYbExPgNBcp0UXd86UYqI/QS7Mr5/VaRwIc4qAyatX3lKo67ARvMkY
         lU/oJnGz0buNY7RemMCzpwJqlJHQMGO49vHYMvReEcLkpcZ3a45k1X3+SzDoDCVQutLF
         RsCA==
X-Forwarded-Encrypted: i=1; AJvYcCWpbQM07ImEM+nUy6A8Po+1S/Q97aZUtyVrv6674u6MbKo6SbzdRgH6DlEwMhQZMvzEdNnja7LlIhVsRW686LKLjkl+wBy438lb17WGag==
X-Gm-Message-State: AOJu0YwyrRhpwNKZHirg8TIXAMnqbgKvttQCYHZeBhEzzh1ZQtlwF95Q
	GQo2lwsLnmL7BQfVMw9qS6xlAA0KTw7wIQvuyXzMvMIcNvGotvFH3jWJAR0et24=
X-Google-Smtp-Source: AGHT+IFH5HuMfmvbE4pmOe8SUsWhXGmBy/f8wCL8BkqKfjRUwp7p68YSbmTclZDRaoQsSL6V13FV8Q==
X-Received: by 2002:a05:6a20:43a0:b0:1a0:60b2:45b with SMTP id i32-20020a056a2043a000b001a060b2045bmr1445690pzl.6.1707864306761;
        Tue, 13 Feb 2024 14:45:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUuBRLYz/ZMeJAh5p4WoSM7f4br1opheRIOVUqkjHYvdjjF+sUGuH9OCmB++AXrk+SYj0c14b2v3mPw++EN5XDbXUgzFjupG5q/2qyZlwfpXk7ulACrPgHmp4r3KNjuLVlqX12ACdOM6raWkbIOSUq2HvhIHlPQKjzHqg2RSsAnT6WjoVb9ntIfUxaXQ78lEaHrGDv1By1Kx5UK/Y9eYvQtynsSTLzuvYmO/JroPwUvPGCYTRZsNKaVHDXL2Wgr68Ql9oDQEQBRIXLlsJAB5f9dVuP6JW0oOzHEGa1FnkQfY1sJUTbp7aeZP+0CR3s3kN7F/lWm0sk7hJOK661u6uz4PF40Z9d0XYHNhlZk242dwNhEkKooSKpml+jjj+Xroa6a3KvQe2FjcC3GQztgrVCGprCGpX0MeQ8Z2Ck=
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id r18-20020a62e412000000b006e0503f467bsm7953728pfh.39.2024.02.13.14.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:45:06 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1ra1WQ-0068Mq-2a;
	Wed, 14 Feb 2024 09:45:02 +1100
Date: Wed, 14 Feb 2024 09:45:02 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
	kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com,
	p.raghav@samsung.com, linux-kernel@vger.kernel.org, hare@suse.de,
	willy@infradead.org, linux-mm@kvack.org
Subject: Re: [RFC v2 13/14] xfs: add an experimental CONFIG_XFS_LBS option
Message-ID: <Zcvw7hcMsOSCrCvg@dread.disaster.area>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-14-kernel@pankajraghav.com>
 <Zcvc20gqm6U6xaD0@dread.disaster.area>
 <gsxwuko2bmajg7wshcxx26p5afmzi6hpvc5u6oecp5slnybdr6@fdky2ksbpvki>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gsxwuko2bmajg7wshcxx26p5afmzi6hpvc5u6oecp5slnybdr6@fdky2ksbpvki>

On Tue, Feb 13, 2024 at 10:54:07PM +0100, Pankaj Raghav (Samsung) wrote:
> On Wed, Feb 14, 2024 at 08:19:23AM +1100, Dave Chinner wrote:
> > On Tue, Feb 13, 2024 at 10:37:12AM +0100, Pankaj Raghav (Samsung) wrote:
> > > From: Pankaj Raghav <p.raghav@samsung.com>
> > > 
> > > Add an experimental CONFIG_XFS_LBS option to enable LBS support in XFS.
> > > Retain the ASSERT for PAGE_SHIFT if CONFIG_XFS_LBS is not enabled.
> > > 
> > > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > NAK.
> > 
> > There it no reason for this existing - the same code is run
> > regardless of the state of this config variable just with a
> > difference in min folio order. All it does is increase the test
> > matrix arbitrarily - now we have two kernel configs we have to test
> > and there's no good reason for doing that.
> 
> I did not have this CONFIG in the first round but I thought it might
> help retain the existing behaviour until we deem the feature stable.
> 
> But I get your point. So we remove this CONFIG and just have an
> experimental warning during mount when people are using the LBS support?

Yes.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

