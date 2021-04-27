Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4AB36BFE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 09:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhD0HMX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 03:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbhD0HMH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:12:07 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C37EC061760;
        Tue, 27 Apr 2021 00:11:24 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id e186so5605081iof.7;
        Tue, 27 Apr 2021 00:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o8L5ZMaubvXb3xbIclAe/yQ2wqz77CZcrOI4jqRRtAg=;
        b=PHAZcfLXvVvhrblorjYGiuz2n26RGPhP+pY0hoL/Bmq+S7WAe7YNxXYciTxixSufmQ
         YBTx2TpMKEz5RCT6bQT/oLfBSGgOu6Aj7lo03S25waBWaEpRtJPnvM/3+1jXnpn2XwL9
         3tIoRFVEtYj7ze+dX0mcuozPBB3MQgHZieMgT/zCB8DZtWcqQNAJ92XymXgP6DmmXVOA
         zWyrqDLSwAsk1TVdaEG/hIk7fIIfpU0aMtNqMoryDy7b3dHwzcWq9WF0MUum6xa7CRwJ
         Kib6AeQGbmbQbbkgfmor8cPq4ePdKBtYdpn+ucu06GmildkVEM2BFrtXtw6mOKj/pgz4
         fABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8L5ZMaubvXb3xbIclAe/yQ2wqz77CZcrOI4jqRRtAg=;
        b=LuF1mjRfnxVDjboe2rNEX98TzeH/1I98zurhIZRq5BMfQrKU406S69LpPyzW23b11Z
         aQVh+d/jic8hF7OaecpbMrTfrNEc9UUuvJpb8TtzHRw7xdT3We02ZKgtSiQ2dgpUD96+
         bIgrGey2WbuRsQ4Ycr2svmgKLzwy1320Or2sN7EY+cSX0j1I0gatOf8zUf0BRmC4wihj
         /MJWrjEM2XgD0VzKYzfDfZOYQVVYDa2AC1/DovyT46BG7dsQfQKLjPTBRTwiu1u6RZeK
         cX+yw6JO340RvpxteCTtUsdq3eLyngKkcVb3vAYonTNJ9Ka5eNiS++DUvggAy1Cpq4D/
         ZsIw==
X-Gm-Message-State: AOAM5300gVt4v0MRa+5CxLL6sKV4EaWLhk9JmoXDpdJLBfCF9lyStfba
        7u9ViqREUIXNGEUNIFChqIGeJLgI+XgD/6LpqHKm9S1V8dY=
X-Google-Smtp-Source: ABdhPJywShhtnftelM+CCIYHp32d1XvxQ6rMdMcBwOyYjVicj5KWzLcNvXCyuMXDmt94nk+CG6LFfVKfSVTE0Y1KyX0=
X-Received: by 2002:a05:6602:58d:: with SMTP id v13mr17367403iox.64.1619507483590;
 Tue, 27 Apr 2021 00:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210426184201.4177978-1-krisman@collabora.com> <20210426184201.4177978-11-krisman@collabora.com>
In-Reply-To: <20210426184201.4177978-11-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Apr 2021 10:11:12 +0300
Message-ID: <CAOQ4uxh_AQCj2XJgVzFp862xhr70FAS6n3QjeeQSd_bizw3Ssw@mail.gmail.com>
Subject: Re: [PATCH RFC 10/15] fanotify: Introduce code location record
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 26, 2021 at 9:43 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> This patch introduces an optional info record that describes the
> source (as in the region of the source-code where an event was
> initiated).  This record is not produced for other type of existing
> notification, but it is optionally enabled for FAN_ERROR notifications.
>

I find this functionality controversial, because think that the fs provided
s_last_error*, s_first_error* is more reliable and more powerful than this
functionality.

Let's leave it for a future extending proposal, should fanotify event reporting
proposal pass muster, shall we?
Or do you think that without this optional extension fanotify event reporting
will not be valuable enough?

Thanks,
Amir.
