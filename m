Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7790B1BD652
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 09:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgD2HmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 03:42:25 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:59929 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgD2HmX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:42:23 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mx0VH-1jEmjV0fTn-00ySHt; Wed, 29 Apr 2020 09:42:22 +0200
Received: by mail-qt1-f169.google.com with SMTP id b1so1117838qtt.1;
        Wed, 29 Apr 2020 00:42:21 -0700 (PDT)
X-Gm-Message-State: AGi0PuYMx5cbpuTZKzYOJvRyKo4AlymN5WrSecm0QOs1GfFxiWKpzBCs
        4TqODyDtwHxrCIrooQoHWMN+OsCU2EbxIlvnbtA=
X-Google-Smtp-Source: APiQypJpUvYWo2LU3ZngNQ2JW3D6wR/VR7VqZhY2dctva2ZkWquiJEYUHe1E74mkf1lS1pWa7NroBC/zYcEQxa9gQho=
X-Received: by 2002:ac8:4c8d:: with SMTP id j13mr32009866qtv.142.1588146140928;
 Wed, 29 Apr 2020 00:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200427200626.1622060-2-hch@lst.de> <20200428120207.15728-1-jk@ozlabs.org>
 <20200428171133.GA17445@lst.de> <e1ebea36b162e8a3b4b24ecbc1051f8081ff5e53.camel@ozlabs.org>
 <20200429061514.GD30946@lst.de> <2014678ca837f6aaa4cf23b4ea51e4805146c36d.camel@ozlabs.org>
In-Reply-To: <2014678ca837f6aaa4cf23b4ea51e4805146c36d.camel@ozlabs.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Apr 2020 09:42:04 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2s3SLw7qehipMCP2m4TG+S089nBiqFfY3c7M2qjVTHWw@mail.gmail.com>
Message-ID: <CAK8P3a2s3SLw7qehipMCP2m4TG+S089nBiqFfY3c7M2qjVTHWw@mail.gmail.com>
Subject: Re: [RFC PATCH] powerpc/spufs: fix copy_to_user while atomic
To:     Jeremy Kerr <jk@ozlabs.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:0F+MXJdpbdc8prDZpJ1o0fXcWKpXA6GHBMcS6NM7GMZHddCJt3d
 lSJ13n+AikE9nKXFORVKe4Qs0Jh+HErHj5vnWBO5TNyhOf60oSgbiK+ra4/t09GZ2ddMWaV
 C5oz1NxXyh/7ozpWKqx9XlmyTYkp/856b70jnOFs1QRSI7UGbYzzaJ612bwdGEvgrsOVFME
 F3lF04orawvvqY6a+6Ihw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0lGVva0neKE=:8/YCBhn/FU+mNBnNGbE08T
 OodQyvsqEpg/TpLsQauCtU7AfaV2xkMHDzG241UV9cxGPDV6V/7+L7RXzRhUMWL+VMpJLXXLP
 hDsTpoymddUSb0x3jbsDJQDtO4aJ4fVX3VoRZQOrdLhcNf7D1XbqJlsmnX46pmUt2elXerNTj
 bo2Cqgc2yxjBzdFjKTgvrK7D3ik/bayNYiPV8jy/+q/ZDb4i5eK6VRuWRy6D1Q9VMlAQ4KKQW
 rM2skiyjNg26/+ebCJUDaIaWtoURJE8rpJiHVmBDUiW406B0ufXXzhUKQT/Hj8fh/8spSY9Qs
 9GaRR6IqmSSQvBJBa7tt/LgC7zDrOfswUgtOhqINmvyIAMBJfSQoMxAJeUOpqg9pOk0dmue7G
 oh+CUX+H/DPSXezN5P80PDjII94v6ylyUaKWv6Q27iloLV6OXbemGpiHGwNwKsT2ZTL7bQ29J
 L1FL8jYEtu7QsaDu2tYYn3LvyGsgoaBTERLrTK97E0Ipj0hwJFVwk5i/vrq8fSjoV1YazLGTb
 WDL2QCAxWhrVLujC0Eo/UdKXhRgHMiaMzKFFzaJQ6kzAa9B2uIc5JS/KDoJjoeoLHwW9kZ5EB
 alaZ155sRgdBp2cUv+6VJmMdOVW+BrKJDqrJlU6cnzilgNv43OBJDdxecYkg9n1KQp3yxLepo
 5RkXKXEX94NGeT3kYHuJKjJ2ULG4U1C4EquOp55vAMTCKDhJNDXTYL73t1caOreK6mM7VU5OT
 kwdwmwvuK0/zjI/yzSTCccCF7sHRvtu/nfjwouqr8JDj0Cw6WfbVOVxXXvw1JelzbK9jw+aTc
 22MrAs4CbMG3smYXxlE/9WIdlJPBBn/QHteMAxFOolE/AQhB/0=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 8:33 AM Jeremy Kerr <jk@ozlabs.org> wrote:
>
> Hi Christoph,
>
> > And another one that should go on top of this one to address Al's other
> > compaint:
>
> Yeah, I was pondering that one. The access_ok() is kinda redundant, but
> it does avoid forcing a SPU context save on those errors.
>
> However, it's not like we really need to optimise for the case of
> invalid addresses from userspace. So, I'll include this change in the
> submission to Michael's tree. Arnd - let me know if you have any
> objections.

Sounds good. A lot of the access_ok() checks in the kernel are redundant
or wrong, I think it makes a lot of sense to remove these.

       Arnd
