Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5822C426D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 15:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406388AbfFLNAj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 09:00:39 -0400
Received: from server.eikelenboom.it ([91.121.65.215]:55200 "EHLO
        server.eikelenboom.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfFLNAj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=eikelenboom.it; s=20180706; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HvkmB5zmkH1Nopajgb0Co97pzTawdlIaMBG8LWGv2pE=; b=eHZ920JvkOCNOKfsZO4Pv+MDHY
        LK4EYXAqMrvHRgw2UmHPQPl9Cl9TK4LYAOTkSRR9ISUJSlvAiPWMgj3LnFPp0ng2P+7XRX+Ern7O3
        MnvU24z1w3i2PIh+jHWnI4xq+5f/kgd5e543YkprN1qxRbjFbv/pJeYouh+xB+9hOkZU=;
Received: from ip4da85049.direct-adsl.nl ([77.168.80.73]:45508 helo=[10.97.34.6])
        by server.eikelenboom.it with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <linux@eikelenboom.it>)
        id 1hb2rh-0004Xv-Ac; Wed, 12 Jun 2019 15:00:33 +0200
Subject: Re: [PATCH] fuse: require /dev/fuse reads to have enough buffer
 capacity (take 2)
To:     Kirill Smelkov <kirr@nexedi.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, gluster-devel@gluster.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <876aefd0-808a-bb4b-0897-191f0a8d9e12@eikelenboom.it>
 <CAJfpegvRBm3M8fUJ1Le1dPd0QSJgAWAYJGLCQKa6YLTE+4oucw@mail.gmail.com>
 <20190611202738.GA22556@deco.navytux.spb.ru>
 <CAOssrKfj-MDujX0_t_fgobL_KwpuG2fxFmT=4nURuJA=sUvYYg@mail.gmail.com>
 <20190612112544.GA21465@deco.navytux.spb.ru>
From:   Sander Eikelenboom <linux@eikelenboom.it>
Message-ID: <f31ca7b5-0c9b-5fde-6a75-967265de67c6@eikelenboom.it>
Date:   Wed, 12 Jun 2019 15:03:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612112544.GA21465@deco.navytux.spb.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/06/2019 13:25, Kirill Smelkov wrote:
> On Wed, Jun 12, 2019 at 09:44:49AM +0200, Miklos Szeredi wrote:
>> On Tue, Jun 11, 2019 at 10:28 PM Kirill Smelkov <kirr@nexedi.com> wrote:
>>
>>> Miklos, would 4K -> `sizeof(fuse_in_header) + sizeof(fuse_write_in)` for
>>> header room change be accepted?
>>
>> Yes, next cycle.   For 4.2 I'll just push the revert.
> 
> Thanks Miklos. Please consider queuing the following patch for 5.3.
> Sander, could you please confirm that glusterfs is not broken with this
> version of the check?
> 
> Thanks beforehand,
> Kirill


Hmm unfortunately it doesn't build, see below.

--
Sander


In file included from ./include/linux/list.h:9:0,
                 from ./include/linux/wait.h:7,
                 from ./include/linux/wait_bit.h:8,
                 from ./include/linux/fs.h:6,
                 from fs/fuse/fuse_i.h:17,
                 from fs/fuse/dev.c:9:
fs/fuse/dev.c: In function ‘fuse_dev_do_read’:
fs/fuse/dev.c:1336:14: error: ‘fuse_in_header’ undeclared (first use in this function)
       sizeof(fuse_in_header) + sizeof(fuse_write_in) + fc->max_write))
              ^
./include/linux/kernel.h:818:40: note: in definition of macro ‘__typecheck’
   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                                        ^
./include/linux/kernel.h:842:24: note: in expansion of macro ‘__safe_cmp’
  __builtin_choose_expr(__safe_cmp(x, y), \
                        ^~~~~~~~~~
./include/linux/kernel.h:918:27: note: in expansion of macro ‘__careful_cmp’
 #define max_t(type, x, y) __careful_cmp((type)(x), (type)(y), >)
                           ^~~~~~~~~~~~~
fs/fuse/dev.c:1335:15: note: in expansion of macro ‘max_t’
  if (nbytes < max_t(size_t, FUSE_MIN_READ_BUFFER,
               ^~~~~
fs/fuse/dev.c:1336:14: note: each undeclared identifier is reported only once for each function it appears in
       sizeof(fuse_in_header) + sizeof(fuse_write_in) + fc->max_write))
              ^
./include/linux/kernel.h:818:40: note: in definition of macro ‘__typecheck’
   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                                        ^
./include/linux/kernel.h:842:24: note: in expansion of macro ‘__safe_cmp’
  __builtin_choose_expr(__safe_cmp(x, y), \
                        ^~~~~~~~~~
./include/linux/kernel.h:918:27: note: in expansion of macro ‘__careful_cmp’
 #define max_t(type, x, y) __careful_cmp((type)(x), (type)(y), >)
                           ^~~~~~~~~~~~~
fs/fuse/dev.c:1335:15: note: in expansion of macro ‘max_t’
  if (nbytes < max_t(size_t, FUSE_MIN_READ_BUFFER,
               ^~~~~
fs/fuse/dev.c:1336:39: error: ‘fuse_write_in’ undeclared (first use in this function)
       sizeof(fuse_in_header) + sizeof(fuse_write_in) + fc->max_write))
                                       ^
./include/linux/kernel.h:818:40: note: in definition of macro ‘__typecheck’
   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                                        ^
./include/linux/kernel.h:842:24: note: in expansion of macro ‘__safe_cmp’
  __builtin_choose_expr(__safe_cmp(x, y), \
                        ^~~~~~~~~~
./include/linux/kernel.h:918:27: note: in expansion of macro ‘__careful_cmp’
 #define max_t(type, x, y) __careful_cmp((type)(x), (type)(y), >)
                           ^~~~~~~~~~~~~
fs/fuse/dev.c:1335:15: note: in expansion of macro ‘max_t’
  if (nbytes < max_t(size_t, FUSE_MIN_READ_BUFFER,
               ^~~~~
./include/linux/kernel.h:842:2: error: first argument to ‘__builtin_choose_expr’ not a constant
  __builtin_choose_expr(__safe_cmp(x, y), \
  ^
./include/linux/kernel.h:918:27: note: in expansion of macro ‘__careful_cmp’
 #define max_t(type, x, y) __careful_cmp((type)(x), (type)(y), >)
                           ^~~~~~~~~~~~~
fs/fuse/dev.c:1335:15: note: in expansion of macro ‘max_t’
  if (nbytes < max_t(size_t, FUSE_MIN_READ_BUFFER,
               ^~~~~
scripts/Makefile.build:278: recipe for target 'fs/fuse/dev.o' failed
make[3]: *** [fs/fuse/dev.o] Error 1
scripts/Makefile.build:489: recipe for target 'fs/fuse' failed
make[2]: *** [fs/fuse] Error 2


