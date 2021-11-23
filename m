Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F747459C65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 07:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhKWGrq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 01:47:46 -0500
Received: from mout.gmx.net ([212.227.15.18]:38347 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230270AbhKWGrq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 01:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637649876;
        bh=mqTghZlQDWC96e4znXis7Ak03d2cVK8eZtpwdHSYW68=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=M1joFZH3HvzhSdAx9iZN8PD/Wx9ZY+qmgCwiKGh+qDgElaJUz2ySfDnzGRrRfTRY7
         4vT/yVfvbV/XHZGr0kF5nTRejI9ctyh38wvJBydrlaEBQmSNzjFaPVDCdmcPWZ5m6Y
         gzkmYL4mL4vY6ijDs5+e0B17nQ8K27eEyRGcKsoU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZktZ-1nBFeW2R4Z-00Wj20; Tue, 23
 Nov 2021 07:44:36 +0100
Message-ID: <5d8351f1-1b09-bff0-02f2-a417c1669607@gmx.com>
Date:   Tue, 23 Nov 2021 14:44:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-US
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>, dm-devel@redhat.com
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Any bio_clone_slow() implementation which doesn't share bi_io_vec?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/KzIMRoAX7PxbEm1Bkj26bYMQrmSjX45HekEQlqPdr3cOtGtt5D
 mvzIVxHRSEfXCCQDXRxzoEgDGcraK1fTwOTwApxlv+r2byjfBFoMh3ADlQPcACmrS7xpSKE
 xidaX7Ig7Bed+WJ7ANBriz2TCzju94j2c8YlMOhhZNLmAY9rqryhwOjrdYAinXg0YBUuqTO
 Y35p1hNbFS+2UmMS3wrfw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wsj5FAmNYto=:8tN16ch8ldn4zdPsIENzqQ
 6z1t1p4zXJbFbnEREbyUSIk9slFxyWrWQkUYAtDXHh0QO7AaF/g9c+7M2nrt8Sc5NpPpUQX8v
 FlldBD+w4ihLq9u1yPbf6/sEAj9Th+k3qQvmPqFWOfN5ObEtF6CvssOy+p1XZOYWOLOBucjXv
 2PfM3mkimUdjyLt717/I8lKP/tfrI2AO40SmmfjjLYJFhGTN60S8P/IBI465IrL0gmnGq5w3j
 5U/fEREgRpD6jDXozCGwmnOP9zoEP2YkVB+gdd6Dh7Iclp6kpY2J9tyCkhhcSLeQZMpu6mtNI
 KS5LXBWFeVA4i1xXnegrY0JfQ7OTzxcYDADVZWelhCmFjaQaxB9cWu9aw3jkGb1IL7ZkIUTz0
 rhzDlQMdhaeetFR27u1w5a5U/nDkGw7H+DgdxlFacJGyjXGutetUhMgDJ+CdgYu0xN+1zKCi3
 FkUnVDSi+lhXAr7T3FH2JQCCIXbTILZjpLEO9OaEE1zsvWd6GzxKIWsi/KayF0mZwH4zkE3xq
 vSRLZMaTog1ZztCP5NJ0rVpUjcs+/oBiT4UHEZUY+l3Xw+suzScBY3fB8mL2lMjC9tYAuwSZ6
 u0IbuaZjJtFG3BoQvLvCkG5YDnnQqaqYfu4e5WaRse+0l8kcgTaud9j2CCZNR5p+RAuJsWmlX
 wY6cEO+GdC90nAOaynXq3KhOKhQto4A/KrRZwN+rR9WP/hxSYDA65L372wXmg/6kFCsnvxsJz
 hECKRiqIC5S8Qvv7vEYhDyBM3cD2Xs2Rsg1y3A/GjKRJmx/4KjQmJIASgFLoxhN3JQTesNEQj
 wIOm7g/lO6iumaSb7N3TrHRYe/rGpmP8gWhsqdmrHChGLbPFLa2LO08ATqRzH15IQdSqy0+9b
 2JdzQlg75oJ4961wwbPeWGEw9iJQOxo+X+7DPqcY22CkOgXO+p+NjD1nNfgEV6lYHiw9OCOcW
 Xvf2amqWprxtKg/jWU3ozthWFkGc1Rjq6aAuZ7cLiGsBXX1Lr0Ncd+us7/hP8ChIW9aMcO+gB
 aInI7HATzEXf3flsM7YCmctFYd2E7j0exj4JlWdEuLq4/6f1P9vLiuOizJc3+HjMFOZxEq5fd
 Yz9zvJrpyuvVwA=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Although there are some out-of-date comments mentions other
bio_clone_*() variants, but there isn't really any other bio clone
variants other than __bio_clone_fast(), which shares bi_io_vec with the
source bio.

This limits means we can't free the source bio before the cloned one.

Is there any bio_clone variant which do a deep clone, including bi_io_vec?



The background story is a little long, with btrfs involved.

Unlike dm/md-raid which uses bio_split(), btrfs splits its bio before
even creating a bio.
Every time btrfs wants to create a bio, it will calculate the boundary,
thus will only create a bio which never cross various raid boundary.

But this is not really the common practice, I'd like to at least change
the timing of bio split so that reflects more like dm/md raid.

That's why the bio_clone thing is involved, there is still some corner
cases that we don't want to fail the whole large bio if there is only
one stripe failed (mostly for read bio, that we want to salvage as much
data as possible)

Thus regular bio_split() + bio_chain() solution is not that good here.

Any idea why no such bio_clone_slow() or bio_split_slow() provided in
block layer?

Or really bio_split() + bio_chain() is the only recommended solution?

Thanks,
Qu
