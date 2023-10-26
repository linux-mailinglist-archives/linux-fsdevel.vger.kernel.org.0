Return-Path: <linux-fsdevel+bounces-1262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886BF7D880E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 20:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4492D2820F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 18:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A093995F;
	Thu, 26 Oct 2023 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XOscnmog"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B5F38FA0
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 18:10:23 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535B3C2
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 11:10:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9becde9ea7bso501345466b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 11:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698343819; x=1698948619; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vTbt9gqKKxXYaVH3DBnhOUVSf9jjJse6rxhifrnnjZk=;
        b=XOscnmogPVD18uaSCG5AznLkn6dvylNHpXDFbAqepN7PtAgiFB0BR/pJPlnOP1RKLM
         xlFzOMVO5V60UxiBa6jxzclbRepjqungsZKvUD6rNPIdXWPXBQz4kqXUnfrPVG7fgXFY
         8kiidtkfC0oW8+dpg6YrzToH75P43tkWZl6KI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698343819; x=1698948619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTbt9gqKKxXYaVH3DBnhOUVSf9jjJse6rxhifrnnjZk=;
        b=NxHyhzmuLmu70qgoIF7lbnVVxI6EhHNOkpJxxLfGHsuAf6ZTapkcOfCz2MWZR5uuLu
         GQ1hSRak8GaHt63OTIDqZuG6Sggf6iLAOzt6M5BI30yquuLqWEyGzCqJ6wWn3KkSMdVk
         fgl5smweTb3gP6ZeEsCIGoLzmCfuZUvsGiEGyIZMJpIVPTxrvhzNGCGLbKVlcdrwHl8n
         Pm2qTSDZRbQdwuNUgX1nLWC1YA+qqu/lD18ttD0pJI/2xKD3YQmjUjkjtw+vSGcj6F2c
         UaL2CSXY/lXIl7aQ8Y5DaF0xyFqIN+aW/PnDrVyt2ViU7Xnc+N2d/m4JtfAx4CsUMlwS
         S4Tw==
X-Gm-Message-State: AOJu0Yz+lF6Ko2z2cWTUVt50gaYS+6j7PgGiFcm79iKsRJMEa0x855Kz
	Xg888pv0PU/UXL9ngUSdL8z32bpRcn9oi4C8lNwjIA==
X-Google-Smtp-Source: AGHT+IEiIFDDySgscT5in2kPJdshimoOeQFzCYW2KhSGBuYyHaSrlfHpOlL6M/AgbvfcMCeRDnVJew==
X-Received: by 2002:a17:907:da9:b0:9ae:614e:4560 with SMTP id go41-20020a1709070da900b009ae614e4560mr640687ejc.29.1698343819731;
        Thu, 26 Oct 2023 11:10:19 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 25-20020a170906225900b0098f99048053sm12348466ejr.148.2023.10.26.11.10.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 11:10:18 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-540c54944c4so2479332a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 11:10:18 -0700 (PDT)
X-Received: by 2002:aa7:c758:0:b0:541:342b:2469 with SMTP id
 c24-20020aa7c758000000b00541342b2469mr1010574eds.1.1698343818276; Thu, 26 Oct
 2023 11:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169786962623.1265253.5321166241579915281.stg-ugh@frogsfrogsfrogs>
 <CAHk-=whNsCXwidLvx8u_JBH91=Z5EFw9FVj57HQ51P7uWs4yGQ@mail.gmail.com>
 <20231023223810.GW3195650@frogsfrogsfrogs> <20231024-flora-gerodet-8ec178f87fe9@brauner>
 <20231026031325.GH3195650@frogsfrogsfrogs>
In-Reply-To: <20231026031325.GH3195650@frogsfrogsfrogs>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 26 Oct 2023 08:10:01 -1000
X-Gmail-Original-Message-ID: <CAHk-=whQHBdJTr9noNuRwMtFrWepMHhnq6EtcAypegi5aUkQnQ@mail.gmail.com>
Message-ID: <CAHk-=whQHBdJTr9noNuRwMtFrWepMHhnq6EtcAypegi5aUkQnQ@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: bug fixes for 6.6-rc7
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, 
	Shirley Ma <shirley.ma@oracle.com>, hch@lst.de, jstancek@redhat.com, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Oct 2023 at 17:13, Darrick J. Wong <djwong@kernel.org> wrote:
>
> Similar to what we just did with XFS, I propose breaking up the iomap
> Maintainer role into pieces that are more manageable by a single person.
> As RM, all you'd have to do is integrate reviewed patches and pull
> requests into one of your work branches.  That gives you final say over
> what goes in and how it goes in, instead of letting branches collide in
> for-next without warning.

I _think_ what you are saying is that you'd like to avoid being both a
maintainer and a developer.

Now, I'm probably hugely biased and going by personal experience, but
I do think that doing double duty is the worst of both worlds, and
pointlessly stressful.

As a maintainer, you have to worry about the big picture (things like
release timing, even if it's just a "is this a fix for this release,
or should it get queued for the next one") but also code-related
things like "we have two different things going on, let's sort them
out separately". Christian had that kind of issue just a couple of
days ago with the btrfs tree.

But then, as a developer, those are distractions and just add stress
and worry, and distract from whatever you're working on. As a
developer, the last thing you want to worry about is something else
than the actual technical issue you're trying to solve.

And obviously, there's a lot of overlap. A maintainer needs to be
_able_ to be a developer just to make good choices. And the whole
"maintainer vs developer" doesn't have to be two different people,
somebody might shift from one to the other simply because maybe they
enjoy both roles. Just not at the same time, all the time, having both
things putting different stress on you.

You can *kind* of see the difference in our git tree if you do

    git rev-list --count --author=XYZ --no-merges --since=1.year HEAD

to see "code authorship" (aka developer), vs

    git rev-list --count --committer=XYZ --since=1.year HEAD

which shows some kind of approximation of "maintainership". Obviously
there is overlap (potentially a lot of it) and the above isn't some
absolute thing, but you can see some patterns.

I personally wish we had more people who are maintainers _without_
having to worry too much about developing new code.  One of the issues
that keeps coming up is that companies don't always seem to appreciate
maintainership (which is a bit strange - the same companies may then
_love_ appreciateing managers, which is something very different but
has some of the same flavour to it).

And btw, I don't want to make that "I wish we had more maintainers" be
a value judgement. It's not that maintainers are somehow more
important than developers. I just think they are two fairly different
roles, and I think one person doing both puts unnecessary stress on
that person.

             Linus

