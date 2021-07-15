Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374D73CA035
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 16:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbhGOOIe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 10:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232011AbhGOOIe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:08:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 446246127C;
        Thu, 15 Jul 2021 14:05:38 +0000 (UTC)
Date:   Thu, 15 Jul 2021 16:05:35 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrei Vagin <avagin@gmail.com>, linux-api@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] move_mount: allow to add a mount into an existing
 group
Message-ID: <20210715140535.eypw5ekwd53kcbab@wittgenstein>
References: <20210715100714.120228-1-ptikhomirov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210715100714.120228-1-ptikhomirov@virtuozzo.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 01:07:13PM +0300, Pavel Tikhomirov wrote:
> Previously a sharing group (shared and master ids pair) can be only
> inherited when mount is created via bindmount. This patch adds an
> ability to add an existing private mount into an existing sharing group.
> 
> With this functionality one can first create the desired mount tree from
> only private mounts (without the need to care about undesired mount
> propagation or mount creation order implied by sharing group
> dependencies), and next then setup any desired mount sharing between
> those mounts in tree as needed.
> 
> This allows CRIU to restore any set of mount namespaces, mount trees and
> sharing group trees for a container.
> 
> We have many issues with restoring mounts in CRIU related to sharing
> groups and propagation:
> - reverse sharing groups vs mount tree order requires complex mounts
>   reordering which mostly implies also using some temporary mounts
> (please see https://lkml.org/lkml/2021/3/23/569 for more info)
> 
> - mount() syscall creates tons of mounts due to propagation
> - mount re-parenting due to propagation
> - "Mount Trap" due to propagation
> - "Non Uniform" propagation, meaning that with different tricks with
>   mount order and temporary children-"lock" mounts one can create mount
>   trees which can't be restored without those tricks
> (see https://www.linuxplumbersconf.org/event/7/contributions/640/)
> 
> With this new functionality we can resolve all the problems with
> propagation at once.
> 
> Link: https://lore.kernel.org/r/20210715100714.120228-1-ptikhomirov@virtuozzo.com
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Mattias Nissler <mnissler@chromium.org>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Andrei Vagin <avagin@gmail.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-api@vger.kernel.org
> Cc: lkml <linux-kernel@vger.kernel.org>
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> ---

Looks good,
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

I also took a look at mount-v2 for CRIU you linked below. Looks like
clean approach.
I'll compile and run the selftests now.
