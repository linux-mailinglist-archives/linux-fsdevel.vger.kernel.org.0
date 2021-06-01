Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BE83973E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 15:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbhFANNm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 09:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhFANNl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:13:41 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2825C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jun 2021 06:11:58 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id p1so8364390uam.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jun 2021 06:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7077Dyh+YDGnNAVDGqIhJHPedBuZ0QWG2BmwzLYPyOE=;
        b=mOWF2fH4vzpM4K88hASPlljlknDxGCqVikan6nD+g6eIBhCloQZwCoOlhNph8a9avb
         PJjl8LES9abQWrxfzSNfh8/FXZTXPTqwJzccU8qlsjvF/IDdsLrT8N2hs/EzAmkGLDqi
         kYS0f0MCle0u6YpmeubmqivlSYpYO1VwMVOEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7077Dyh+YDGnNAVDGqIhJHPedBuZ0QWG2BmwzLYPyOE=;
        b=bxPQaxXwT3y7Nz4IC8L3GXcVwGgiVqYHJ0JDiVnSmuMPR95cIw1QtZixk5DXyRK+dp
         03dMAPaSC5rV20Ogrzq9wlyxRaFKIYnvj3tIT1SDIfL8eHlTSc06iK9nISBRZdkAcLMS
         UHOX5KP4yL5rr5IGgdRjNB7rKwPU+AnrXWC6aGlX6mK2BghAC5RtNJhMbiOxIi/AJfpG
         +nisS+3wK9nc5hAbEFXMKAThngoDlZ5raYGhW0vqkntDDj9cWkMhvH7W3T9PMsGupPhg
         VJTPu2D75+wGyjFOGhrYaDUu/nt5NRsXu81kLLrkZKhupRrvl6Xe0XsSJawR2prXLm/H
         9wMw==
X-Gm-Message-State: AOAM530Jvy383XSwwjWw8kxavqJ9PX1vHHY1Ih0j7RDmQBEhy4FXqWvd
        QW8tSohUAwbTcRTMiTqZGBX3rGBaN/EFIWAAk1PPhw==
X-Google-Smtp-Source: ABdhPJzOiGtl010Vi+hi7PV0RZgu51OPFYuSBEL/0eqeynMnkCMAjPcyXnals/v8+1/iVL2IMiV18T8hp94QcaKQ6Bo=
X-Received: by 2002:ab0:2690:: with SMTP id t16mr14884741uao.9.1622553118062;
 Tue, 01 Jun 2021 06:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
 <162218365578.34379.12523496660412609287.stgit@web.messagingengine.com>
In-Reply-To: <162218365578.34379.12523496660412609287.stgit@web.messagingengine.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 1 Jun 2021 15:11:47 +0200
Message-ID: <CAJfpeguSnA-At8Jca0Ge0aytC22Gb5YmKpxbEy82rR7btczh5Q@mail.gmail.com>
Subject: Re: [REPOST PATCH v4 3/5] kernfs: switch kernfs to use an rwsem
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 28 May 2021 at 08:34, Ian Kent <raven@themaw.net> wrote:
>
> The kernfs global lock restricts the ability to perform kernfs node
> lookup operations in parallel during path walks.
>
> Change the kernfs mutex to an rwsem so that, when opportunity arises,
> node searches can be done in parallel with path walk lookups.

I don't see how this could have any drawbacks.

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
