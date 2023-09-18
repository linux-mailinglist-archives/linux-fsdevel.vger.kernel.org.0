Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD51D7A4D7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 17:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjIRPvb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 11:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIRPva (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:51:30 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7161BD0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 08:49:03 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4050bd2e33aso11115645e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 08:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695051918; x=1695656718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9C9LMcgPXK0TzUHzj0llknV/i85+aKix5XO5smaiKOg=;
        b=c9xZpkCV8Asbv7XbZ3gD2EdLzn4tA5Fb26690ng0v5f+ZWA1e3OueAxI1ogBroIDLj
         u7hTjtRmtX6bznxsQIVNfHeNrfw4pEcn5JiD36brmC0io89gz5iwUIa3X9t6GGnFMDNW
         f6w6GZYDD5kL+DwkLi0WxYRIl6VuMH7duadDPuSe5fx6bPyySuZcXJsXTwIlyZCMkGP1
         7e7eoUih9Tco2FpfEov/ME1bakNxEzKi5oKDxnnSKh2dplcgJt7Z1I7ErevsYOMmBKbi
         hI3kNUa8WVbjrswaGnJXta/QY2s3YNDGASxJ3Q7cEpZhgXcHb/KK1gKlb/iaTUA0YqEO
         pDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051918; x=1695656718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9C9LMcgPXK0TzUHzj0llknV/i85+aKix5XO5smaiKOg=;
        b=X5jVeE8jm3cYwe0UBSlb64K3AvHJ2NduLhCkdsAUsvfZMFKH2zvDMAt2Ig1E9F2xqO
         VhF5BC/+xAvXqbkULbaY9EV+Elt9YsVIyIOEVNX359iqPGaMQLmDoVEASZSDJJ/HHRYS
         4m/zHLRxfI4M9zyswkMhkgw2nJo6TgrTxHMCtdgjBDbL1owGGiKEFGfPJFPuqtWny/M0
         9oA9Wd183kSHthE7P8xYiEYZt4vtgyieR4P1l1bbHmZ4FqMqu6wVztsebtpqJ+rnAGKi
         9vyfdG80YWCQ9hKZzEsRf5Zql8GdQHP8b7F/RE6SQKmW+D4Mem+Im1JpepBbyQ2iVwPn
         M8OA==
X-Gm-Message-State: AOJu0Yz8ER5Q1hG8ed2Ef6hi+g3QLj15xfLNBpozBVe6qJpCdedyN6H7
        vw0TKGJMqN7zvkVj257HP9WFUK2ZxmCu80EdJavMkbpj9n6hZ70A
X-Google-Smtp-Source: AGHT+IFxQdZh1SSfT9LlcG8tguxv47bZ6juM9AMuyh79H5Fz+DIpzr7wrwRr2QmAMQ4fv2MEeFcw6z/nFXVW1jP2iKM=
X-Received: by 2002:a2e:3e0e:0:b0:2b6:bc30:7254 with SMTP id
 l14-20020a2e3e0e000000b002b6bc307254mr7553866lja.13.1695045474573; Mon, 18
 Sep 2023 06:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230918123217.932179-1-max.kellermann@ionos.com>
 <20230918123217.932179-3-max.kellermann@ionos.com> <20230918124050.hzbgpci42illkcec@quack3>
In-Reply-To: <20230918124050.hzbgpci42illkcec@quack3>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Mon, 18 Sep 2023 15:57:43 +0200
Message-ID: <CAKPOu+-Nx_cvBZNox63R1ah76wQp6eH4RLah0O5mDaLo9h60ww@mail.gmail.com>
Subject: Re: [PATCH 3/4] inotify_user: add system call inotify_add_watch_at()
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        amir73il@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 2:40=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> Note that since kernel 5.13 you
> don't need CAP_SYS_ADMIN capability for fanotify functionality that is
> more-or-less equivalent to what inotify provides.

Oh, I missed that change - I remember fanotify as being inaccessible
for unprivileged processes, and fanotify being designed for things
like virus scanners. Indeed I should migrate my code to fanotify.

If fanotify has now become the designated successor of inotify, that
should be hinted in the inotify manpage, and if inotify is effectively
feature-frozen, maybe that should be an extra status in the
MAINTAINERS file?

Max
