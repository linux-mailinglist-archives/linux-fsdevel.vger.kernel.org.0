Return-Path: <linux-fsdevel+bounces-60032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D9EB41018
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 00:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA42544DBA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 22:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C462773F3;
	Tue,  2 Sep 2025 22:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQxcsotU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2164D20E00B
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756852834; cv=none; b=sPzHPfRB46oybudXflKNOGNiPO2OyIz/GzcOXGyiEomaJUUPZcxD5h5aNna6lyK7qnMuVyN8ZeOeWPTQYC32iqK94rHw/mF5MWBQnCJMxrdB6FJJ6BcMWIXy2gYE/MddNPeMBYmfqPHV11mtomN6GQmlI6vmV8Oy5vpcAd3aR9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756852834; c=relaxed/simple;
	bh=kFTDP3EMFoOB4KZJmFMStdwGCzmgiGLh4hkXXKQNXMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSJi5r5K1XtJz7p1oOwN7aD5VHs+4shuViOR/Ew0ftnZV3sUlWgQeZ8hO2g/MlaufpDOi76itb/DAFyIX2/WDOYEr2i0zH+Pco7foA3zqhjMZd0BZgu1YcIMrc7ogrTFznmpEvycagibE+2JrynTYPxvKFIb20YGQkjWEorZjEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQxcsotU; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b3319c3a27so2968111cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Sep 2025 15:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756852832; x=1757457632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRVe9bAcKVFnkz+iX/ZIpZHxD0vklNb23sPGac04Cbo=;
        b=AQxcsotUB6SvUXTfVkQJbWQ95llTvnKuQqnOrLSnrNEkfa0CcabcRPAQ9CrCNMTaqs
         2CBmgMyUl94DG68yidcXOVRxOmMbuIx7cwac2Qv9D/f/4n7JKlWwCWXTM09szVOx2aOk
         aTwIRhNKvoZ2hgkx+DrRy6+oyCx1pO0wJn0jZaRXe85e5wiSPIodA9m52EpgCJpVL+H3
         M3pFl2qPhr5VdsXpKQBxs8I9fqN8fVrjQU2uT9wl6yKuAERl9R/mE4IRZKojDtfgmjfi
         mUZkdRaNQsJsB2qk73Ejpq/GGY69EQ1w5Md40uCf1qeDpJJSda5c1WS5hbGXJBJg2K8p
         UNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756852832; x=1757457632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRVe9bAcKVFnkz+iX/ZIpZHxD0vklNb23sPGac04Cbo=;
        b=dB/jcusBtqSVdtZFlU/iS5uMxL2nteP3Qk7vdIQ05b0QuedXFfi3nxtpvQewKyxDyv
         N+QNquqY5C9RPJflFIPzrpxfW05se6CLGDQ3IGQcp+KMoQjPAF6hNcQ8fWS2I8+/fdur
         J6JAxHruvqceZSOmTftFf5ws9iJOLSOAcNfQaRV2MnEq6xAjbFQZ3nZi/Dpy3RhXz0hi
         es1ygE1zlf3FsoTCtWLvIT6QY0av5gIqCxbLf8uBd8rv4FbvEkOR05qfuJAYmFwMEKWl
         2hvKdeRvtQAqF5mwMLM+XJOTnjHdRRAryAIWIRfxUFAZbqbmO7Z8KY583YBwYCd8Up3s
         Edcg==
X-Gm-Message-State: AOJu0Yyig/enkV1LXFQ1nOKEqa9Ihag6w+r6kYn8idj324driqXUPndO
	gHOb5XtXKb/RljmY7D1Kgo930m7u43pnTs00i6tviK8aYBFf+GAmAhiOpgMrio1oJALF0EtCtEO
	cebNnVi1YJgqbukh0UGk2KEtnko3WRn4=
X-Gm-Gg: ASbGncvJsQ4WtEfg02Yr1D1mixe57oiEeGdSYWrcgtgiShahG0sW/f9cC+TJAQy+Jb0
	Sl3eVEr7t8z7uUkVRrn9ZR4DDDJ+LQw0B5f1rZfhccMzyxopiazFqZ9kZviU1YPg3JOCTd1lqB1
	9zoD8eZ0Qo+49E11YF5DJGbfemwd/P+ZxDtejCt1Ur1vXMH7tMcYZGe8LZQikojOqpRtn0RHAi2
	OdrGMlh
X-Google-Smtp-Source: AGHT+IGFR7mdx+WkhCi/xPYFUzaH9Qu/eayM/gqlLUqSWz2SpThvXT9x3if4xaKGi7ciyIdJcLOunLU3WOi1ZJEHKVc=
X-Received: by 2002:a05:622a:54f:b0:4b2:e41c:8f5f with SMTP id
 d75a77b69052e-4b31d86fc2cmr145141361cf.17.1756852832009; Tue, 02 Sep 2025
 15:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902144148.716383-1-mszeredi@redhat.com> <20250902144148.716383-4-mszeredi@redhat.com>
In-Reply-To: <20250902144148.716383-4-mszeredi@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 2 Sep 2025 15:40:21 -0700
X-Gm-Features: Ac12FXxbjN2t6E6A5xPdk7dlInnbE76D5o1z94yaR7V8YZ4WQOB_vPjufUZH_Aw
Message-ID: <CAJnrk1btHZdaZ_sypFFwx8QwMGYcTA7my8H-znY+P5tuDJtw=w@mail.gmail.com>
Subject: Re: [PATCH 4/4] fuse: add prune notification
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jim Harris <jiharris@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 7:44=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com>=
 wrote:
>
> Some fuse servers need to prune their caches, which can only be done if t=
he
> kernel's own dentry/inode caches are pruned first to avoid dangling
> references.
>
> Add FUSE_NOTIFY_PRUNE, which takes an array of node ID's to try and get r=
id
> of.  Inodes with active references are skipped.
>
> A similar functionality is already provided by FUSE_NOTIFY_INVAL_ENTRY wi=
th
> the FUSE_EXPIRE_ONLY flag.  Differences in the interface are
>
> FUSE_NOTIFY_INVAL_ENTRY:
>
>   - can only prune one dentry
>
>   - dentry is determined by parent ID and name
>
>   - if inode has multiple aliases (cached hard links), then they would ha=
ve
>     to be invalidated individually to be able to get rid of the inode
>
> FUSE_NOTIFY_PRUNE:
>
>   - can prune multiple inodes
>
>   - inodes determined by their node ID
>
>   - aliases are taken care of automatically
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

