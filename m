Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB765AC49E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Sep 2022 16:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiIDOC5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Sep 2022 10:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiIDOCz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Sep 2022 10:02:55 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41DB20F61
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Sep 2022 07:02:53 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id 190so6590363vsz.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Sep 2022 07:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lvXHHqPKJz6gmlkmuCkKVo1yoML+Wo2LIqK6gHt3YiY=;
        b=e5JNpX9w5fAWaVuKryVV/vR1wp7QI0tp9NBmiAejTTSxdcj45qSXObXiBpXH6s1Iad
         gVQMwzRxCkY7mPAbbnaa50+P4cCWaV8YrtMN2xhm7KjrPiYy4dgtuUqsyv/daodnWjlx
         GTsiymHkz8yN0bV+NYoJVNrFIqU4XwQarQcNxCGoPYf3ynIIoYldyPQGjYwxGBStywmf
         39jAc12u+EQN3f9KnlRLsvE5gBJQz5DU5Wn04caf1EjDdrFslaphpKLaELpZl2L4MJBu
         l24OoTHkQMAH+EkXxoGNTuwr2YXtIVKlm2rw7J8e3DD93AhbxftNALKJ3jPeXiCFQg8v
         1WmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lvXHHqPKJz6gmlkmuCkKVo1yoML+Wo2LIqK6gHt3YiY=;
        b=zPeqn4GopC50Zgj9HAPTdOm+EhLwlYsZKUOOU2fcD+abfAC6K8mFl0V1GTEBFUg4S9
         5TKixskGAMg1aFUSFkPzYYUPMIAP2FFxIxYQmTLpQm42gcwvnLMf6pkM9+u5+NI73u8k
         AUyrOzn9MpuriXR0/3Gztbm+mpJz16ry7ubnE3LOMHBHNwdUtQrogvELY5hBb1wYyDEj
         HiQeCqBOmM5u5jI5jjfAqUb1Tyu6gvi/ejReYAbidFpkqCIKBmi75XgeNyyErbh7/B6d
         AGkBncncXmony4R1HF65ybxVxeDU2f8nEuGv34RF4hPQaU+F0Z9FwbL9V35qMG36g244
         pvjA==
X-Gm-Message-State: ACgBeo0nvDLkc8J+rs4ISIO4koS74Dx2q2kM6+vI35JwlU55oAXulMpg
        RNY5os+5zBW0rt8UkwhsEnFYX0UPcSJN6+2Lc1Q=
X-Google-Smtp-Source: AA6agR4oK+nS9OCcC7Y/Pu13WrulXmSnyr5APq5qCaVEjqGriKKHApl+CoDY/1Bjab4aLPp9qycEl+kt53O8x4gMRNk=
X-Received: by 2002:a67:b90f:0:b0:390:cb3e:efb8 with SMTP id
 q15-20020a67b90f000000b00390cb3eefb8mr12040442vsn.71.1662300172772; Sun, 04
 Sep 2022 07:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-MHhAw+mgY5MHJ3G-agK0AqxgXZjL5Zr97CeCRzDjjSTHr0w@mail.gmail.com>
In-Reply-To: <CAJ-MHhAw+mgY5MHJ3G-agK0AqxgXZjL5Zr97CeCRzDjjSTHr0w@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 4 Sep 2022 17:02:41 +0300
Message-ID: <CAOQ4uxieX+oJJV_NZt9cQVn=TTFbZdbpQq9kY0N64iy=JHMn6A@mail.gmail.com>
Subject: Re: Fanotify events on the same file path
To:     Gal Rosen <gal.rosen@cybereason.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 4, 2022 at 4:26 PM Gal Rosen <gal.rosen@cybereason.com> wrote:
>
> Hi,
>
> I am using a single reader thread from an Fanotify file descriptor.
> The reader thread pushes file events into a queue.
> There are multiple worker threads which pop from the queue and do some actions on the file path (like file scanning for viruses).
> We have been told by the third party we are working with for the scanning API that we are scanning the same file path in parallel with 2 different objects.
> Is it possible to get multiple events on the same file path before response on the first event ?
>

Yes, there is nothing preventing that.
Multiple threads opening the same file will result in multiple
FAN_OPEN_PERM events, each with a different event->pid.

Thanks,
Amir.
