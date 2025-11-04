Return-Path: <linux-fsdevel+bounces-66983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36300C32D94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 20:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27B914E4A5F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 19:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA652DF709;
	Tue,  4 Nov 2025 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bl+2armP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F37C2DF137
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762286387; cv=none; b=r/fUWCY4mF38wvhsL/1SAwE4gNZx6olowMbFsockOK9H7mdoFb9KXZ9y2naWSwx5Fov5LBmpCAebSBujWyeIJWT2OkLVZIokeWCr9fvf4RqjhwJIiKt32Z3O1IGoX1NeX2Lmc4cFNqS00SBH6l0hGjn+zMJBIQO7P+Fi7mDio1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762286387; c=relaxed/simple;
	bh=uX5r1UKRh5hgHYfFHLXZmC8nv6FyW44YAn4VdccjSK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KyxBQxIBX0GxvstckCG7bjjVcGZlb/EqSBSgBXMJH4V0JawTHfrpGr5HFl19Embu1L6NeeY6kXmS0kl9vCWkaneparJ8XzOZyHjWDMRKxTx29kHLTcLvWcxti/N7VWjbeK0129pmbV0AsFmr+z2bmwgf1ywD6SWr0BdCaFBtdFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bl+2armP; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4eceef055fbso99616741cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 11:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762286384; x=1762891184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36eMqKQl+uirAL1DF9qIP4HwS9UCvveHLkgtu9cSplc=;
        b=Bl+2armP1z4USVfymA4A7DLqbOFcGUvKpEyRaJqyXJ4YwCwyLLnrHac7cM5PRz1cpC
         FNLKXUeRv+M6j2owJPWxYHBJ8rEHiXq2lEOnX/C/YTf9oPmmYIcyX+dw45EkVgmAkOeO
         uRu0qVf+5jZVxJhsqjhyMtCCgq2WyFgr6h7aSKoG1tUdt8h9o86SQsQY2a40RsUvyjbJ
         nq6h7VnZraeJVabYrqSTTKPD0XskUgiOVFIdA39IPQBSnN24En5i3Sldv4/GlWIWkrkH
         No+fqyd2uMy1qhyMSesgKMcWQGk9ylO34LZsGrnRHwIU2LItb5zcm0mgiHnRzrIwIwQe
         zRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762286384; x=1762891184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36eMqKQl+uirAL1DF9qIP4HwS9UCvveHLkgtu9cSplc=;
        b=TmqEbxTTdYwLGi7zhXOEVKxRhPbHz4QeTB3poBIl6O0Kh+nlc/9K0o4fBy5CpYK1MC
         MaOZbKtnWgKIaqleTd6qDyMdjIaRyUhdMZdRMt7QJZgwi1GoLWOfsBHlqy1uGgmrkp8p
         U995a4n8wN7Rw3oI1ziqFO97eC8eie7P7ML60BZkUZClNfSD074ESXlpAOlrbS6KHZ/F
         YkQez69P0vL43ReIHWutd0B+cpj7dISm9M84sybAiz3CCD/gqvR1eQF9EsK4+C/BEev4
         9+PgvzvScLAySX/uEwC4EVlaHFdmvdbffuZPSzhxHQqfmwcoGhkd884jIJgTwSU9znxB
         /Ltg==
X-Forwarded-Encrypted: i=1; AJvYcCUm9eihfKIgRRQaY7f/hIUAPnFvLYwcKYz8Tjn5uSXJu9No7J9R80GeBef0DqFzDucF32Oe5FJ9ZW/W/EWd@vger.kernel.org
X-Gm-Message-State: AOJu0YxQQQBZkZyKT3OnhlAOfdB6e0fnllwzN98XBeOhCzVelQkX7CUR
	w9HvvafWb9CZVpAr0n9nNdzQsAAkNZ/ubbL+5FDq7vSwb7B+Tfiifsf4QhOWGPBcYyrGA4ecvRa
	OZxYBh4e4kgcbF6kzm479JlrDVyKx3tg=
X-Gm-Gg: ASbGncu8YhdwJwLP8QcAdm+n5WtIySrgJYfySTk8v7s1qcsPTk+fqYWOU/0jWs5d4zb
	7ZrAjXEsV9fJigKTNwLumbNnRYkM2zqAVSo1eqDfEzQd9OBHcOV8MEQlJsL0pMyxw330T8KKHnY
	PpJYOEhPkpOoCyNtlffuz46jcAs/ba096wmDNbpHL2OFz2l1lrGvJQ0mAekO9JIs257K9mNzr1w
	S8WqqN+2QMUsEkjhmCrQvLLFe2lyl/b1ZfMMtNneWghjt8aC6qsHApuK/lMFoMSjvHj9mdD6VuE
	DHGhBgRlg4lSi2OGYCqWJ+uxdG0toHlG
X-Google-Smtp-Source: AGHT+IFYUEk67d6wkrel09WbcgZrushIXlVlBxALy1cPC783ZW824tJLnztCsyN2ea6YD8lujb+bG2kRyCR6kw7wRfk=
X-Received: by 2002:ac8:59d3:0:b0:4ed:6324:f53f with SMTP id
 d75a77b69052e-4ed72626098mr10004961cf.39.1762286384520; Tue, 04 Nov 2025
 11:59:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs> <176169809296.1424347.6509219210054935670.stgit@frogsfrogsfrogs>
In-Reply-To: <176169809296.1424347.6509219210054935670.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 4 Nov 2025 11:59:33 -0800
X-Gm-Features: AWmQ_bliLv8l5EMdKsrWCti1ZZIHas10dyMFCTrkaG3nWk2BbLH5E6LmnFVgPEU
Message-ID: <CAJnrk1akz4YKkB_rywe=9bPn8Uur-WS4f6hCxx2K7kXuMeEJJg@mail.gmail.com>
Subject: Re: [PATCH 2/5] fuse: signal that a fuse inode should exhibit local
 fs behaviors
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 5:43=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Create a new fuse inode flag that indicates that the kernel should
> implement various local filesystem behaviors instead of passing vfs
> commands straight through to the fuse server and expecting the server to
> do all the work.  For example, this means that we'll use the kernel to
> transform some ACL updates into mode changes, and later to do
> enforcement of the immutable and append iflags.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

