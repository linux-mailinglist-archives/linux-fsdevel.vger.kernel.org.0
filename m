Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BED369BBD7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 21:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjBRUaC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 15:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRUaB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 15:30:01 -0500
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A792214EA5;
        Sat, 18 Feb 2023 12:29:59 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 96952C01E; Sat, 18 Feb 2023 21:30:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676752221; bh=MJagL46Q61+YbfyuoP4/F/MhRpNNtR2aGh+V7psBaus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VlkQeF7rLAogYl7v6cMOn4v21gvZvYgga67P3u3CadkY6y/0nxU9rxPF32G21DpJO
         Mm0gTlvYqR7+mJCbBbcwkTOuFpOJlbaWCzUygLC2hn85u4p7KhysR4IDVHNnikSYwu
         fj5PNaAHrJoE9d6RUa44OLFWiA5rpbRx2CE4ZS10z07tnHQ7QoA/iztLtPiaKR90Dk
         vLOyRWyAafKNvuiP3JyKIgUg8d18ysImnYglNET+x9GMl6rpuqrXklkPzfv4fcZBGc
         jbtHZ+JroUMrAdA4mve5ZS/IdLAdhmOjg3wap+FzO5VWsspo4+GnC3IQJQnhaZhVI6
         VCrshQkxnsGlw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 52AB4C009;
        Sat, 18 Feb 2023 21:30:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676752220; bh=MJagL46Q61+YbfyuoP4/F/MhRpNNtR2aGh+V7psBaus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p7vV70phFOoUGW1hQbPmuz6+rHCs1vU5JmFv+0v4QfGpPc9qc+nibWVPkV+VQPi51
         c4UH8COVxpcuFiWJzOyrTN588YpT24Z6XOciECid9MfUa/XcJkZAj7ZpoAjWAACnxv
         oiLPYlLp/2C5mlec0/NmAA/Z5zo1JvBDb3UG7sAbWS/NHeuy8Vax7KKfzpCSTGHWuJ
         B0GzeTK9pSDMSljs7PAw67nG85rKFix0dgA8UOOoGvhRmYjMsaMnmV4snF/nx3yfQj
         aI5rpg76shJoqYzvBQK7LObTXBk+mUgNMd2u9ZlGr7imgNELdItWTrQVoH00UvsRif
         0yeOWPFkzbY7w==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 236bd756;
        Sat, 18 Feb 2023 20:29:51 +0000 (UTC)
Date:   Sun, 19 Feb 2023 05:29:36 +0900
From:   asmadeus@codewreck.org
To:     Eric Van Hensbergen <ericvh@gmail.com>
Cc:     Eric Van Hensbergen <ericvh@kernel.org>,
        v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux_oss@crudebyte.com
Subject: Re: [PATCH v4 10/11] fs/9p: writeback mode fixes
Message-ID: <Y/E1MCTVslQzozEb@codewreck.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-1-ericvh@kernel.org>
 <20230218003323.2322580-11-ericvh@kernel.org>
 <Y/Ch8o/6HVS8Iyeh@codewreck.org>
 <Y/DBZSaAsRiNR2WV@codewreck.org>
 <CAFkjPTk=GOU+2D3hORsGntwYc-OLkyMH4YMSY_ERfBXdkq2_hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFkjPTk=GOU+2D3hORsGntwYc-OLkyMH4YMSY_ERfBXdkq2_hg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Van Hensbergen wrote on Sat, Feb 18, 2023 at 10:40:27AM -0600:
> This is stupidity on my part, but can you send me your setup for
> fscache so I can test the way you are testing it?  It is the one thing
> I still haven't incorporated into my test matrix so definitely a blind
> spot I appreciate you exposing.

I mounted with fscache but I didn't actually have a backend running when
testing, so there's really not setup involved -- just qemu's
'-virtfs local,path=/tmp/linux-test,mount_tag=tmp,security_model=mapped-file'
and
'mount -t 9p -o debug=1,cache=fscache,trans=virtio tmp /mnt'

In that case, fscache basically acts like loose, except it also does all
its cookies stuff so it's sort of useful to test anyway.


I also have a setup that runs cachefilesd on top but it wasn't involved
here; for completeness if you want to test:
- add an extra disk to qemu
qemu-img create -f qcow2 /tmp/disk 1G
'-device virtio-blk-pci,drive=hd0 -drive if=none,file=/tmp/disk,snapshot=on,id=hd0'
- just runs cachefilesd (ignore hardcoded nix paths, that's my easy way out
of running straight out of initrd without making it huge):
---
if [ -e /dev/vda ]; then
        /run/current-system/sw/bin/mkfs.ext4 -q /dev/vda
        mkdir /cache /var/run
        mount /dev/vda /cache
        echo -e 'dir /cache\ntag cache' > /etc/cachefilesd.conf
        echo 'modprobe cachefiles'
        echo '/nix/store/4vy0z1ygfidfmbzaxblkmzv7j0irhhwc-cachefilesd-0.10.10/bin/cachefilesd -s -d > /cache/log 2>&1'
fi
---
And that's basically it; you should see files poping up in /dev/vda when
you do reads (iirc writes weren't cached through last I looked)
-- 
Dominique
