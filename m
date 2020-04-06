Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84BA819F67F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 15:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgDFNNE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 09:13:04 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:33949 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbgDFNNE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:13:04 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mr9OA-1j07J23ARS-00oEbm; Mon, 06 Apr 2020 15:13:02 +0200
Received: by mail-qk1-f174.google.com with SMTP id 130so885179qke.4;
        Mon, 06 Apr 2020 06:13:02 -0700 (PDT)
X-Gm-Message-State: AGi0PubPIKvOp7wEV94JFy/6Yi+xh/HWiNI99awjCqQ098tIJ/hITfpK
        VbYzbcZnY3fmrl4nK+Lrb9IjaFUfEe2ySIwTeT4=
X-Google-Smtp-Source: APiQypK8zqZk5uLnoIubAdQeJgGTiVyPkpSzxxqDGQ7EZ4yy/nSPnZICKVDeK2bBxoQfBZJEyLjW+qUVp5bYDvV/ciM=
X-Received: by 2002:a37:2714:: with SMTP id n20mr6302088qkn.138.1586178781557;
 Mon, 06 Apr 2020 06:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200406120312.1150405-1-hch@lst.de> <20200406120312.1150405-2-hch@lst.de>
In-Reply-To: <20200406120312.1150405-2-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 6 Apr 2020 15:12:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1YdCuChb0mOU1+27PHK9qK6NGkuKfrHQa4LC=1LZmPTw@mail.gmail.com>
Message-ID: <CAK8P3a1YdCuChb0mOU1+27PHK9qK6NGkuKfrHQa4LC=1LZmPTw@mail.gmail.com>
Subject: Re: [PATCH 1/6] powerpc/spufs: simplify spufs core dumping
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:6XdMQ65OOioIRuqHqq3+7QMYDDx6jRkjOZCrP8n45lczowS/cdI
 B09il7WTGW1J7FQ/gHbXqtzafbYmmYNYaomppPgH11VXbffng5qbvuD+UhX4/vU2P1TU0lY
 lMkrPkxerZ8IGSKk6vOR6emstBbqPTE+sVGNmBoqKOVUbniYJoEs5i/FncKhF0vhNN/W2zu
 MAqzmzusyaJSaZ46ZL5iQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:La6cY6+qeSw=:gCyGgPoDKIxSW2RoC1zxtL
 6CI+6gRoK0r9H6g9tsBuJo0U2E/jUrgmNY52jOf9aS9UW8i0jZcx3f4QTjgtO+S1/KVyjeAm3
 mssvbM3r+xDMVJZJh270i1KcYZruzHgiamQ/hidXxsQ5Zu6qirr6UecqZToG7GS2wUMg/CIz2
 GsI9LIWyp/Momo0L1H/RVGpYPOZzyaTuXwgrQzfdmaFw/cuAENqGcrCTEQxD9RPQ910jm5IHd
 mI8SwbS64bZ9uJ2o8pCU5y6AlPvC+ARTIkEeTp4WQo53oRZyxmBBmJjnJawz8vpvGicqFpgq8
 pEP2LgLKnGoKHsWoL0OsQw/eztuvonX/UWdes0iN6x497eFxzNjiW6zKa4SNBfKPBavh9DB+E
 YzTHuDnc/BYNIqt3Eb0efTyoC/A/ZwWyxTWq833pkTYBl/z/hdpn+ObU9M/sgOKutzCCMsiyX
 Z64EGfiZjAVgE5QNjlaXCxNcZRoGEqA9ke/9lRHWgaoeWLbQYoeAGZ9zAYn6h9lzqIKdyFZmo
 lak4KPm/iM+qdZSUOAgFf7+Z0Ah19Nf5BWFI3c3cSbtpF1szQTeOoOGhHehJ1bbUC5xwU2li1
 UuZ7suVrUqUNQsIithlFEambJDiVOumynNAih5YD5dbcHJeedQATZVKwx/w61zSvFi9C5hMt1
 Y9YF/DLapn1wK+pnYqbl8Fx7YLXG6nKIiL0KTLglnvUMZbONp/1pRqK0MuIjSVLSHFb94MYJr
 8t6lQfvy+Sut/QCbfjqaNF7TPU9RcLOLaZ7o1DB1IkJW2MrCOC8sfob4LWtr7UbdHZtxN4GLK
 RS2wZhNLV0VISp6O+J7nEjzYgA2j093Wn0EH079f1GLN0S5eIM=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 6, 2020 at 2:03 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Replace the coredump ->read method with a ->dump method that must call
> dump_emit itself.  That way we avoid a buffer allocation an messing with
> set_fs() to call into code that is intended to deal with user buffers.
> For the ->get case we can now use a small on-stack buffer and avoid
> memory allocations as well.

I had no memory of this code at all, but your change looks fine to me.
Amazingly you even managed to even make it smaller and more readable

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
