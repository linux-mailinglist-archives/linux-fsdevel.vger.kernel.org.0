Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDF56A4C8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 21:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjB0U4I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 15:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjB0U4H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 15:56:07 -0500
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5498B25E12;
        Mon, 27 Feb 2023 12:56:00 -0800 (PST)
Received: from [10.0.0.182] (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id B9847161B9A;
        Mon, 27 Feb 2023 21:55:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1677531357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=asQWI/0KqQ7Vskc9EMNo967uGziRnDRjnTbun9Xsibw=;
        b=UU3tgWQJlBiGN4SmpF7FcfyXOhVg5CL0CPSW88hsr0v4bwPMpywNAcyE9F9bIloot+Kfyy
        +zca8OffoaqtiDEe75NBHICli7NZAzc4uP7TRyCPlrcesgDQiNPFyjD8SGVHPiKezcGEHi
        SK6nVNWE+3aAli4ddv45LvsvHMQmUbY=
Message-ID: <cee2e3ea-14a6-c51f-7ce6-6a67dabff6f1@ixit.cz>
Date:   Mon, 27 Feb 2023 21:55:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [RESEND v2 PATCH] init/do_mounts.c: add virtiofs root fs support
To:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, helen.koike@collabora.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        wsa+renesas@sang-engineering.com, akpm@linux-foundation.org
References: <20230224143751.36863-1-david@ixit.cz> <Y/zSCarxyabSC1Zf@fedora>
 <Y/zxO9PMaES8SenN@redhat.com>
Content-Language: en-US
From:   David Heidelberg <david@ixit.cz>
In-Reply-To: <Y/zxO9PMaES8SenN@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you all!

We'll drop this patch in next MesaCI kernel uprev without this patch!

David

On 27/02/2023 19:06, Vivek Goyal wrote:
> On Mon, Feb 27, 2023 at 10:53:45AM -0500, Stefan Hajnoczi wrote:
>> On Fri, Feb 24, 2023 at 03:37:51PM +0100, David Heidelberg wrote:
>>> From: Stefan Hajnoczi <stefanha@redhat.com>
>>>
>>> Make it possible to boot directly from a virtiofs file system with tag
>>> 'myfs' using the following kernel parameters:
>>>
>>>    rootfstype=virtiofs root=myfs rw
>>>
>>> Booting directly from virtiofs makes it possible to use a directory on
>>> the host as the root file system.  This is convenient for testing and
>>> situations where manipulating disk image files is cumbersome.
>>>
>>> Reviewed-by: Helen Koike <helen.koike@collabora.com>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> Signed-off-by: David Heidelberg <david@ixit.cz>
>>> ---
>>> v2: added Reviewed-by and CCed everyone interested.
>>>
>>> We have used this option in Mesa3D CI for testing crosvm for
>>> more than one years and it's proven to work reliably.
>>>
>>> We are working on effort to removing custom patches to be able to do
>>> automated apply and test of patches from any tree.
>>>
>>> https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/.gitlab-ci/crosvm-runner.sh#L85
>>>   init/do_mounts.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>> Vivek, do you remember where we ended up with boot from virtiofs? I
>> thought a different solution was merged some time ago.
> We merged a patch from Christoph Hellwig to support this.
>
> commit f9259be6a9e7c22d92e5a5000913147ae17e8321
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Wed Jul 14 16:23:20 2021 -0400
>
>      init: allow mounting arbitrary non-blockdevice filesystems as root
>
> Now one should be able to mount virtiofs using following syntax.
>
> "root=myfs rootfstype=virtiofs rw"
>
> IIUC, this patch should not be required anymore.
>
> Thanks
> Vivek
>
>> There is documentation from the virtiofs community here:
>> https://virtio-fs.gitlab.io/howto-boot.html
>>
>> Stefan
>>
>>> diff --git a/init/do_mounts.c b/init/do_mounts.c
>>> index 811e94daf0a8..11c11abe23d7 100644
>>> --- a/init/do_mounts.c
>>> +++ b/init/do_mounts.c
>>> @@ -578,6 +578,16 @@ void __init mount_root(void)
>>>   			printk(KERN_ERR "VFS: Unable to mount root fs via SMB.\n");
>>>   		return;
>>>   	}
>>> +#endif
>>> +#ifdef CONFIG_VIRTIO_FS
>>> +	if (root_fs_names && !strcmp(root_fs_names, "virtiofs")) {
>>> +		if (!do_mount_root(root_device_name, "virtiofs",
>>> +				   root_mountflags, root_mount_data))
>>> +			return;
>>> +
>>> +		panic("VFS: Unable to mount root fs \"%s\" from virtiofs",
>>> +		      root_device_name);
>>> +	}
>>>   #endif
>>>   	if (ROOT_DEV == 0 && root_device_name && root_fs_names) {
>>>   		if (mount_nodev_root() == 0)
>>> -- 
>>> 2.39.1
>>>
>
-- 
David Heidelberg
Consultant Software Engineer

