Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D17A3B2382
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 00:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhFWWVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 18:21:38 -0400
Received: from out20-38.mail.aliyun.com ([115.124.20.38]:53659 "EHLO
        out20-38.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWWVh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 18:21:37 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08139847|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00281446-0.000855108-0.99633;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.KWzt2Lk_1624486756;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.KWzt2Lk_1624486756)
          by smtp.aliyun-inc.com(10.147.42.22);
          Thu, 24 Jun 2021 06:19:17 +0800
Date:   Thu, 24 Jun 2021 06:19:18 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dhowells@redhat.com
Subject: Re: the major/minor value of statx(kernel samples/vfs/test-statx.c) does not match /usr/bin/stat
In-Reply-To: <20210623204910.GO28158@twin.jikos.cz>
References: <20210617181256.63EB.409509F4@e16-tech.com> <20210623204910.GO28158@twin.jikos.cz>
Message-Id: <20210624061917.A9CD.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

> On Thu, Jun 17, 2021 at 06:12:56PM +0800, Wang Yugui wrote:
> > the major/minor value of statx(kernel samples/vfs/test-statx.c) does not
> > match /usr/bin/stat. 
> > 
> > major/minor of statx result seems be truncated by something like
> > old_decode_dev()?
> 
> I've checked the code first, both stat/statx seem to be doing the same
> thing.
> 
> > [root@T640 vfs]# ./test-statx /ssd/
> > statx(/ssd/) = 0
> > results=1fff
> >   Size: 200             Blocks: 0          IO Block: 4096    directory
> > Device: 00:31           Inode: 256         Links: 1
> 
> So Device is 00:31, printed as two fields in hex.
> 
> > Access: (0755/drwxr-xr-x)  Uid:     0   Gid:     0
> > Access: 2021-06-16 19:16:56.644344956+0800
> > Modify: 2021-05-06 16:14:33.676248229+0800
> > Change: 2021-05-06 16:14:33.676248229+0800
> >  Birth: 2020-11-18 14:03:35.324915316+0800
> > Attributes: 0000000000002000 (........ ........ ........ ........ ........ ..-..... ..?-.... .---.-..)
> > [root@T640 vfs]# stat /ssd/
> >   File: ¡®/ssd/¡¯
> >   Size: 200             Blocks: 0          IO Block: 4096   directory
> > Device: 31h/49d Inode: 256         Links: 1
> 
> And here it's also 31, the 'h' suffix means it's hexadecimal and "49d"
> si the same value in decimal.
> 
> > Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
> > Access: 2021-06-16 19:16:56.644344956 +0800
> > Modify: 2021-05-06 16:14:33.676248229 +0800
> > Change: 2021-05-06 16:14:33.676248229 +0800
> >  Birth: -
> > 
> > vfat output sample:
> > [root@T640 vfs]# ./test-statx /boot/efi/
> > statx(/boot/efi/) = 0
> > results=17ff
> >   Size: 4096            Blocks: 8          IO Block: 4096    directory
> > Device: 08:01           Inode: 1           Links: 3
> 
> 08:01
> 
> > Access: (0700/drwx------)  Uid:     0   Gid:     0
> > Access: 1970-01-01 08:00:00.000000000+0800
> > Modify: 1970-01-01 08:00:00.000000000+0800
> > Change: 1970-01-01 08:00:00.000000000+0800
> > Attributes: 0000000000002000 (........ ........ ........ ........ ........ ..-..... ..?-.... ........)
> > [root@T640 vfs]# stat /boot/efi/
> >   File: ¡®/boot/efi/¡¯
> >   Size: 4096            Blocks: 8          IO Block: 4096   directory
> > Device: 801h/2049d      Inode: 1           Links: 3
> 
> 801h == 0801h the same value, so it's just a matter of formatting the
> output and the values are indeed the same.
> 
> If you change the format in test-statx.c to  "%2xh/%2dd" and the value
> to "(stx->stx_dev_major << 8) + stx->stx_dev_minor", the output is
> exactly the same.


'/bin/stat' output (struct stat).st_dev in both hex and decimal.

coreutils-8.32/src/stat.c
    case 'd':
      out_uint (pformat, prefix_len, statbuf->st_dev);
      break;
    case 'D':
      out_uint_x (pformat, prefix_len, statbuf->st_dev);
      break;

But I thought it output the major and minor of  (struct stat).st_dev.

That is my bad.  Thanks a lot.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/06/24


