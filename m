Return-Path: <linux-fsdevel+bounces-57178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 646E7B1F55B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 18:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6BE16B4C7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 16:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C162BE7B8;
	Sat,  9 Aug 2025 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tx73WWHc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE3E190692;
	Sat,  9 Aug 2025 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754755700; cv=none; b=OXOGui/dLBd+tqWHvxiwHLjZabG1g+s2NA+ujrk9/V+jmii7x/TxA+5JxsqnWlX04Igosjoe+fNR9EDYYebMoUfM9SnDs6VNI05RrXZs8pDeR8VMMNRRobL9nfggTJNZZd42zokIaNCZWwTFZlXvljcTm5btGipGTb/VFDx8EW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754755700; c=relaxed/simple;
	bh=Ufaxx+IfF2XAwJC0bJUHBGNG54r+MorybcTOPrfdJaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4RtoUhN7mAq8qr0/qQhpcS3DFaJ5ThMtANB/Nj4wPjml3wJTnQzNpwCF4N1txiy1cRZRspnU3BOXTY9uYp3mJj7pZ/QNEZ4NFppUD2LVg5tExyJ5phldiUGkpFHkJoGh/ZyvYhiyDFqqVKctB8JkIzVHDAwEeiHIVdKxzl/eo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tx73WWHc; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af922ab4849so463281066b.3;
        Sat, 09 Aug 2025 09:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754755694; x=1755360494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ufaxx+IfF2XAwJC0bJUHBGNG54r+MorybcTOPrfdJaA=;
        b=Tx73WWHcNZxOoVC6Tl8ZICfvnLBOWG8As34DjDnVjML2701Pajwj2xNAZQidS7T+lY
         FT33xwdieUPfu3dx+AjuVWQ4BJ4ZIkivR8is8y7MWO2VJ5Wodo9dBkEMlEId5wUXFoJe
         e4Z/M46MJSNdfQZp1Rbf2E1MJFeaek2dYab2sP6lO+38hrS8iOr+p7H4bdsrzwTPL9Du
         AoFim+Ys4FeUhufP3pNzMBZcs7j9Yk293MLgI7sDvnBfpi76cdZregS1QBHC2+rl06HA
         4hnqjxLg9h2sOawnzGnk2YSZDqL85hKYuU9ivR5p3Vj26UtnZx3Q209Ue8aSvlgPbnfB
         Tcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754755694; x=1755360494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ufaxx+IfF2XAwJC0bJUHBGNG54r+MorybcTOPrfdJaA=;
        b=ZuTDHTYDRakMUMTOPJKAOEaJIO6zODd1vsbmnThhX+i/rqlP16aogll0IsxCb+NaP6
         QMN3ciwys23vCRuiUWGBZM1H7lSDZ4n0TcCdeBRu7cqGQzDjz0USTqFL9otLLHCze8nV
         gfouXDWOkVUEXflbmJd//sdaasyPdSbvf13/RybOPDpGZC6RNDod4aUEbcrBposgZ43k
         ifAlQqi8y7soK6hUJz8TVRLiuX9LL7fCt4vJ3jzhVyY+3F+GDHJ9/vd4cc4mVufuM5Ef
         eaABzZFYJCE3ZGTMJcY4klrj3o43YFo/R+8ILsUadBYJGOl8n7q2gf7XbooRhU9B+VFL
         VUgw==
X-Forwarded-Encrypted: i=1; AJvYcCUf9LO0ChTOLT3fNPxbXsBW8c2v7Ib2t44pu9R+/BJ9zO62mwC9/7fGjvjnrMcZx2la0O3kBjvgHbGftqr9bQ==@vger.kernel.org, AJvYcCVgWeBtpWyGiNPXW+iLJv/Egp0kZ1Zaao6AWkqVs7zDCrbD1B9VJSamFmXeBa+gTPHSsYkN6tw8G3MrowQn@vger.kernel.org, AJvYcCXXdOIaf/uImgJMhYaE5gnH0T71rOwbMeG3DDs5chFc1krH3NIau/49bB2I60nkI9AIbJfZPKF3bT6rOTVL@vger.kernel.org
X-Gm-Message-State: AOJu0YybTdHIHweDTRA392MKXNA67yOH0wutQi0XuIZe2zYxgmOBElQZ
	tLNGOJTRZYxlHRIIsKWCPa+ek+xmZi6Q4H1P9rZGGB11W9mXTqNbp/wNIlGWyQzzBkWyqbhKWDr
	9VHOsp4B0CGe5vMTQS94+/CqsXuIhxG0=
X-Gm-Gg: ASbGnctU83VgdHM7ofbggxOIve44Vw0cqJphGLJBpjKinm7Mk0rPPV2T7IayNJYk80W
	hDJDktGTG9VMPqeIDcs1YIuEaSa0X/kLYhy0fRDGYkida2G9eXgWeM4Fkws9pxeD6q1Hr1O0AvF
	D/IWhXDP4ireFkDxPq7VKyfqhmf/lJkl5OrvMnW90+1PJDqRq3G7W/FfS2GJSiOTA44Y7iHlqo0
	tbD/C0=
X-Google-Smtp-Source: AGHT+IF2wokC1FoGnEmT8nxhTkWU0r3sYovpSj4TMBjhgpqFblGVc6zJxH12qFYUNW6qhfkU9b5EX09xCEQsNhxAq0E=
X-Received: by 2002:a17:907:7e9c:b0:af9:bdfd:c60c with SMTP id
 a640c23a62f3a-af9c65b5604mr600478666b.47.1754755694159; Sat, 09 Aug 2025
 09:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com> <CAOQ4uxgPiANxXsfnga-oa1ccx3KKc1qeVWLkyv=PPczY-m9zhg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgPiANxXsfnga-oa1ccx3KKc1qeVWLkyv=PPczY-m9zhg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 9 Aug 2025 18:08:02 +0200
X-Gm-Features: Ac12FXwRowk5MZdjdmJvl1wX56Mra6b_t3cSUtI9Q_rWJBumfeUkBqo2hWtl_qE
Message-ID: <CAOQ4uxj13iGDE-tz91BLpjOcJror77-pG4CkxQB18YDXX0kUkg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/7] ovl: Enable support for casefold filesystems
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 9, 2025 at 11:17=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Fri, Aug 8, 2025 at 10:59=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@i=
galia.com> wrote:
> >
> > Hi all,
> >
> > We would like to support the usage of casefold filesystems with
> > overlayfs to be used with container tools. This use case requires a
> > simple setup, where every layer will have the same encoding setting
> > (i.e. Unicode version and flags), using one upper and one lower layer.
> >
> > * Implementation
> >
> > When merge layers, ovl uses a red-black tree to check if a given dentry
> > name from a lower layers already exists in the upper layer. For merging
> > case-insensitive names, we need to store then in tree casefolded.
> > However, when displaying to the user the dentry name, we need to respec=
t
> > the name chosen when the file was created (e.g. Picture.PNG, instead of
> > picture.png). To achieve this, I create a new field for cache entries
> > that stores the casefolded names and a function ovl_strcmp() that uses
> > this name for searching the rb_tree. For composing the layer, ovl uses
> > the original name, keeping it consistency with whatever name the user
> > created.
> >
> > The rest of the patches are mostly for checking if casefold is being
> > consistently used across the layers and dropping the mount restrictions
> > that prevented case-insensitive filesystems to be mounted.
> >
> > Thanks for the feedback!
>
> Hi Andre,
>
> This v3 is getting close.
> Still some small details to fix.
> With v4, please include a link to fstest so I can test your work.
> I already had a draft for the casefold capable and disabled layers
> in 6.17 but I did not post it yet.
> Decide it would be better to test the final result after your work.
> I'd started to adapt the test to the expected behavior for 6.18,
> but it's just an untested draft for you to extend:
> https://github.com/amir73il/xfstests/commits/ovl-casefold/
>
> Please make sure that you run at least check -overlay -g overlay/quick
> sanity check for v4 and that you run check -g casefold,
> which should run the new generic test.
>

Also, please remove the RFC label for v4.
We are pass the point of RFC.

Thanks,
Amir.

