Return-Path: <linux-fsdevel+bounces-62501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1815AB95891
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 12:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1CE3BAF19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 10:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD24313D48;
	Tue, 23 Sep 2025 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="pckSlIWt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66F12877ED
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625104; cv=none; b=V7+01rdt/+X3AqzR2XdYxaCaCxjj+mvBhxmpm/FbhSaT/XZz14rjc78OazCgKNI2DS1iTHJUdyirBzcb6G9oLrD7FsjY2E7ngG73vYYEdfCjKdkVlBXMWt3lLPP/chlk05f3KElEnprtrE09ksZS3vp0P1FZHeGRoEah4uTJgL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625104; c=relaxed/simple;
	bh=u05A7RSPrMA23Ioo5xBvgm7DFkSo7Zh74Ae5+s5YCP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LO6X2R3i66n+uDnKoqwM9SAGsSo5uLVhl+SvjeBFlifu6Cumemn9uZE45Lz5thCYppnBUsmVp1GWixzrdCNTwycH2Rqok7Ft+gVfF8HWHquRxJ38XjauTg8CQloQ//05AOzf8iR+xpNPp6DcjbvCfvVlzhH72RLydVxzLgCAQng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=pckSlIWt; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b38d4de61aso64434481cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 03:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758625102; x=1759229902; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vzx50T9NIjBgPuSwI92zqQFIGqvfQ+lLip04R8s9Q7A=;
        b=pckSlIWtmfH16LL9bwznZhlh9pDtE75iroRDSv/In9M7IKTkkHkT+umF0p1CtIJxMN
         fgOU/Jltu2H6wvRGYqvIktXsPO6yEvbzTfH9jzh/IBuOG+ZWsWbRnR2lAnDa8hfbqixg
         Kv4m+hnZh827ySyZJSawcfuQEMQc8VcwZ+aKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758625102; x=1759229902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzx50T9NIjBgPuSwI92zqQFIGqvfQ+lLip04R8s9Q7A=;
        b=oyq4zePSkFICY15SqXDhyZ+hg6kpkjF+1ISh9y/s9k/WdycC2fiOK5h430iOrwnSTo
         9ZV4694Ykb86k+v2EIFWSrGAm/z7PH65Ju0s1As7UZsSmPGCjYs3QY8QvHpfM6/pj9il
         Zd7KqRXKE77/XxU62EB1/lLLPmIgtkoY2blFJa1NIyOTOtqYpaRe6nMN51zNkGlCf6xX
         Fk1pb9S9eIrSFwTlKBM1dNlMpWqR0CwlqCFH35SAP1DzVzhjq0B0ZD70FG+4nAcakRy9
         h1EzUoI5wA74I1D2lBV8BdwfjvUEp0nZe6DbYtk8lGILXYMmTZtFCDHocHv5oPfWVdGW
         sUgA==
X-Forwarded-Encrypted: i=1; AJvYcCUuPdAlCfxxveXSvmaX9Q5h1qmrAfEgFbaEbznctRH3NM8zcHpnYMJQgqKzdIxCC1/NMXgdJ0jvtQvr+jwc@vger.kernel.org
X-Gm-Message-State: AOJu0YwnobT2jj4D1+UxqmyMA/fr2GhsNqE6zmZQDSoXMe/VaDT9BSn9
	udGK+y0mTZaEa4QcmFMVwSTdvFIWgDyKxOfRhrmVKVlHYYYo464kwYDRwFcYjfBjh415hdl1Ipm
	1jDjz1x8qJLNA8VdL9fd2NYuklh0Tu9I7uRX5kodkNg==
X-Gm-Gg: ASbGncs+XuMinu1fdISspX7142tJoZaXKwuA7t2UtFk+HmKSAv42IyuQQWyBuc43cX2
	KeMpQL2nUAY/7S6Rt8iQLmchALjmOXrJuyMA6drzHQx0wAbNycWBpTzcNPBi0Q9H9dHm40S6Vqq
	BWWNla+PQxUFK/e3RMFNx6oJhZhbbVG84/CDfu0aqL6FRN4n8Ozfu1+2uc/sir61622fEqYMSC6
	3fBrvHOsV3gxs72X2RQ2f3rFVJ5pjkzylGrStI=
X-Google-Smtp-Source: AGHT+IHrBdqbxgU/C0Vi+Ne+IrUvy3ET6zpgpaEITlNHyHR5ORplHmslGcfwWozRKSAxLwI0YrnqgAa9S7f648Zh3Jc=
X-Received: by 2002:a05:622a:2619:b0:4b5:d60c:2fc8 with SMTP id
 d75a77b69052e-4d372c2729fmr24484011cf.71.1758625101848; Tue, 23 Sep 2025
 03:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs> <175798150092.381990.6046110863068073279.stgit@frogsfrogsfrogs>
In-Reply-To: <175798150092.381990.6046110863068073279.stgit@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Sep 2025 12:58:10 +0200
X-Gm-Features: AS18NWC45Lz3Ni2C3kcZ99E2IaRQEufZKgXrRrF26XmsmK0JttNV2M5b7uffbKA
Message-ID: <CAJfpegtTtjWkH6d_-3QmdEPYiZBWxRfaY07JSboFxd3AgJLjOA@mail.gmail.com>
Subject: Re: [PATCH 3/8] fuse: capture the unique id of fuse commands being sent
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net, 
	linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Sept 2025 at 02:24, Darrick J. Wong <djwong@kernel.org> wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> The fuse_request_{send,end} tracepoints capture the value of
> req->in.h.unique in the trace output.  It would be really nice if we
> could use this to match a request to its response for debugging and
> latency analysis, but the call to trace_fuse_request_send occurs before
> the unique id has been set:
>
> fuse_request_send:    connection 8388608 req 0 opcode 1 (FUSE_LOOKUP) len 107
> fuse_request_end:     connection 8388608 req 6 len 16 error -2
>
> (Notice that req moves from 0 to 6)
>
> Move the callsites to trace_fuse_request_send to after the unique id has
> been set by introducing a helper to do that for standard fuse_req
> requests.  FUSE_FORGET requests are not covered by this because they
> appear to be synthesized into the event stream without a fuse_req
> object and are never replied to.
>
> Requests that are aborted without ever having been submitted to the fuse
> server retain the behavior that only the fuse_request_end tracepoint
> shows up in the trace record, and with req==0.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Applied, thanks.

Miklos

