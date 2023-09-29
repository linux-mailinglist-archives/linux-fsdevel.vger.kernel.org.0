Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490117B2FCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 12:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjI2KPn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 06:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjI2KPl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2D4F9
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 03:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695982502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y+YLg6Czk6dgkt/tgnfnHZXULlWBelzg6ldun7brdvc=;
        b=GVPzQSIjiLj3txiZTJsPTGYjiVcEwAJ+4e7+Hs6EZuwBols/m5m8yVMojKlZ9b/QyhhDe3
        SJfu+4lAX5JzHJyMW9aqfe88q2/eBpvhKjhvaNy7H6jFLJDPZtWsXck9neyDkvczWGyQJH
        HcPqaP4890ofTVN7Ed2XnPiPtzfQYl0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-pJpEOTV8O3SqZPpzLitFdA-1; Fri, 29 Sep 2023 06:11:45 -0400
X-MC-Unique: pJpEOTV8O3SqZPpzLitFdA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-577f80e2385so16886545a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 03:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695982305; x=1696587105;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y+YLg6Czk6dgkt/tgnfnHZXULlWBelzg6ldun7brdvc=;
        b=KOrIB2GTcXpfsrHXH7QaBUy8Q+uEX9pVQ/m43lxFnR2eMcuwInv0vnRVdVCIOdjvdC
         LM57to0QZZe3UKwvoxZC1EOgcTspVJo7/Ofn271gIwTyCW/adgSNFLovy+EuInWIUaPf
         dzqhG6Scb+li55xmCOnDtokiwiVFe/1cFZWC67rAwuRiaIQC7PHvHDPhYQNDpnM7rOes
         h5D6Smr3edarzSL3O9s0LTz4sDNpjbyu7Vvr+5HIDUUVBYQ9uxS7K2gBxV7I8zOtv3BA
         9Gk2PfhrLzSkV2MbttZ98tCAmJ5p/7juLj1QD6VwQBu64swEgT1i83JkHqI8A4DQpapr
         3TZQ==
X-Gm-Message-State: AOJu0Yyo0gOix/MIkmBNfOroGT24Uzq8z4W95oO677qZAgdvrHuGAzCS
        VdnvW1YxlSZI/O59qj4GL1Sy5hRkAJTHOeFg0eOj5CvTAwrf3ZvtxPDQs6Ljgd1UGYzQeWFiuBJ
        8Y8FEV5GFnU96kxXHsm+/eU9fpw==
X-Received: by 2002:a05:6a20:100a:b0:15e:921d:19c5 with SMTP id gs10-20020a056a20100a00b0015e921d19c5mr3237418pzc.54.1695982304770;
        Fri, 29 Sep 2023 03:11:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6PkfjrmkpYGlYj7z6rsWAfRDW4wjaxIopf6vSedWZMgKA8Z9qWd5RHgGqE1i0FX0mIYyROA==
X-Received: by 2002:a05:6a20:100a:b0:15e:921d:19c5 with SMTP id gs10-20020a056a20100a00b0015e921d19c5mr3237399pzc.54.1695982304320;
        Fri, 29 Sep 2023 03:11:44 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id i16-20020a17090332d000b001c6189ce950sm10068213plr.188.2023.09.29.03.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 03:11:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------NVL90zIkYN4W03Myqjnk9mJs"
Message-ID: <81872248-bd11-9a8c-e34b-6637f8bc88e5@redhat.com>
Date:   Fri, 29 Sep 2023 20:11:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Endless calls to xas_split_alloc() due to corrupted xarray entry
Content-Language: en-US
To:     Zhenyu Zhang <zhenyzha@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux XFS <linux-xfs@vger.kernel.org>,
        Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shaoqin Huang <shahuang@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CAJFLiB+J4mKGDOppp=1moMe2aNqeJhM9F2cD4KPTXoM6nzb5RA@mail.gmail.com>
 <ZRFbIJH47RkQuDid@debian.me> <20230925151236.GB11456@frogsfrogsfrogs>
 <CAJFLiBKQPOMmUPTAe-jHpPjLEx+X2ZNUKD20qXh4+0Ay+napDw@mail.gmail.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <CAJFLiBKQPOMmUPTAe-jHpPjLEx+X2ZNUKD20qXh4+0Ay+napDw@mail.gmail.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------NVL90zIkYN4W03Myqjnk9mJs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Zhenyu & Darrick,

On 9/26/23 17:49, Zhenyu Zhang wrote:
> 
> The issue gets fixed in rc3. However, it seems not caused by commit
> 6d2779ecaeb56f9 because I can't reproduce the issue with rc3 and
> the commit revert. I'm running 'git bisect' to nail it down. Hopefully,
> I can identify the problematic commit soon.
> 

The issue is still existing in rc3. I can even reproduce it with a program
running inside a virtual machine, where a 1GB private VMA mapped on xfs file
"/tmp/test_data" and it's populated via madvisde(buf, 1GB, MADV_POPULATE_WRITE).
The idea is to mimic QEMU's behavior. Note that the test program is put into
a memory cgroup so that memory claim happens due to the memory size limits.

I'm attaching the test program and script.

guest# uname -r
6.6.0-rc3
guest# lscpu
Architecture:           aarch64
   CPU op-mode(s):       32-bit, 64-bit
   Byte Order:           Little Endian
CPU(s):                 48
   On-line CPU(s) list:  0-47
    :
guest# cat /proc/1/smaps | grep KernelPage | head -n 1
KernelPageSize:       64 kB


[  485.002792] WARNING: CPU: 39 PID: 2370 at lib/xarray.c:1010 xas_split_alloc+0xf8/0x128
[  485.003389] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink vfat fat virtio_balloon drm fuse xfs libcrc32c crct10dif_ce ghash_ce sha2_ce virtio_net net_failover sha256_arm64 virtio_blk failover sha1_ce virtio_console virtio_mmio
[  485.006058] CPU: 39 PID: 2370 Comm: test Kdump: loaded Tainted: G        W          6.6.0-rc3-gavin+ #3
[  485.006763] Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20230524-3.el9 05/24/2023
[  485.007365] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  485.007887] pc : xas_split_alloc+0xf8/0x128
[  485.008205] lr : __filemap_add_folio+0x33c/0x4e0
[  485.008550] sp : ffff80008e6af4f0
[  485.008802] x29: ffff80008e6af4f0 x28: ffffcc3538ea8d00 x27: 0000000000000001
[  485.009347] x26: 0000000000000001 x25: ffffffffffffc005 x24: 0000000000000000
[  485.009878] x23: ffff80008e6af5a0 x22: 000008c0b0001d01 x21: 0000000000000000
[  485.010411] x20: ffffffc001fb8bc0 x19: 000000000000000d x18: 0000000000000014
[  485.010948] x17: 00000000e8438802 x16: 00000000831d1d75 x15: ffffcc3538465968
[  485.011487] x14: ffffcc3538465380 x13: ffffcc353812668c x12: ffffcc3538126584
[  485.012019] x11: ffffcc353811160c x10: ffffcc3538e01054 x9 : ffffcc3538dfc1bc
[  485.012557] x8 : ffff80008e6af4f0 x7 : ffff0000e0b706d8 x6 : ffff80008e6af4f0
[  485.013089] x5 : 0000000000000002 x4 : 0000000000000000 x3 : 0000000000012c40
[  485.013614] x2 : 000000000000000d x1 : 000000000000000c x0 : 0000000000000000
[  485.014139] Call trace:
[  485.014321]  xas_split_alloc+0xf8/0x128
[  485.014613]  __filemap_add_folio+0x33c/0x4e0
[  485.014934]  filemap_add_folio+0x48/0xd0
[  485.015227]  page_cache_ra_unbounded+0xf0/0x1f0
[  485.015573]  page_cache_ra_order+0x8c/0x310
[  485.015889]  filemap_fault+0x67c/0xaa8
[  485.016167]  __xfs_filemap_fault+0x60/0x3c0 [xfs]
[  485.016588]  xfs_filemap_fault+0x54/0x68 [xfs]
[  485.016981]  __do_fault+0x40/0x210
[  485.017233]  do_cow_fault+0xf0/0x300
[  485.017496]  do_pte_missing+0x140/0x238
[  485.017782]  handle_pte_fault+0x100/0x160
[  485.018076]  __handle_mm_fault+0x100/0x310
[  485.018385]  handle_mm_fault+0x6c/0x270
[  485.018676]  faultin_page+0x70/0x128
[  485.018948]  __get_user_pages+0xc8/0x2d8
[  485.019252]  faultin_vma_page_range+0x64/0x98
[  485.019576]  madvise_populate+0xb4/0x1f8
[  485.019870]  madvise_vma_behavior+0x208/0x6a0
[  485.020195]  do_madvise.part.0+0x150/0x430
[  485.020501]  __arm64_sys_madvise+0x64/0x78
[  485.020806]  invoke_syscall.constprop.0+0x7c/0xd0
[  485.021163]  do_el0_svc+0xb4/0xd0
[  485.021413]  el0_svc+0x50/0x228
[  485.021646]  el0t_64_sync_handler+0x134/0x150
[  485.021972]  el0t_64_sync+0x17c/0x180

After this, the warning messages won't be raised any more after the clean page
caches are dropped by the following command. The test program either completes
or runs into OOM killer.

guest# echo 1 > /proc/sys/vm/drop_caches

[...]

Thanks,
Gavin
--------------NVL90zIkYN4W03Myqjnk9mJs
Content-Type: application/x-shellscript; name="test.sh"
Content-Disposition: attachment; filename="test.sh"
Content-Transfer-Encoding: base64

IyEvYmluL3NoCgpjZ3JvdXBfcGF0aD0iL3N5cy9mcy9jZ3JvdXAvdGVzdCIKCmlmIFsgISAt
ZiAvdG1wL3Rlc3RfZGF0YSBdOyB0aGVuCiAgIGVjaG8gIkNyZWF0aW5nIC90bXAvdGVzdF9k
YXRhIgogICBkZCBpZj0vZGV2L3plcm8gb2Y9L3RtcC90ZXN0X2RhdGEgYnM9MUcgY291bnQ9
MgpmaQoKaWYgWyAhIC1kICR7Y2dyb3VwX3BhdGh9IF07IHRoZW4KICAgbWtkaXIgJHtjZ3Jv
dXBfcGF0aH0KZmkKCmVjaG8gMTE1Mk0gPiAke2Nncm91cF9wYXRofS9tZW1vcnkubWF4CmVj
aG8gMTAyNE0gPiAke2Nncm91cF9wYXRofS9tZW1vcnkuaGlnaAplY2hvIDc2OE0gPiAke2Nn
cm91cF9wYXRofS9tZW1vcnkubG93CmVjaG8gMCA+ICR7Y2dyb3VwX3BhdGh9L21lbW9yeS5t
aW4KZWNobyAwID4gJHtjZ3JvdXBfcGF0aH0vbWVtb3J5LnN3YXAubWF4CmVjaG8gMCA+ICR7
Y2dyb3VwX3BhdGh9L21lbW9yeS5zd2FwLmhpZ2gKZWNobyAwID4gJHtjZ3JvdXBfcGF0aH0v
bWVtb3J5Lnpzd2FwLm1heCAKCmVjaG8gMSA+IC9wcm9jL3N5cy92bS9kcm9wX2NhY2hlcwpl
Y2hvICQkID4gL3N5cy9mcy9jZ3JvdXAvdGVzdC9jZ3JvdXAucHJvY3MKLi90ZXN0IGJyZWFr
LW9uLWVhY2gtc3RlcAoK
--------------NVL90zIkYN4W03Myqjnk9mJs
Content-Type: text/x-csrc; charset=UTF-8; name="test.c"
Content-Disposition: attachment; filename="test.c"
Content-Transfer-Encoding: base64

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKLyoKICogQ29w
eXJpZ2h0IChDKSAyMDIzICBSZWQgSGF0LCBJbmMuCiAqCiAqIEF1dGhvcjogR2F2aW4gU2hh
biA8Z3NoYW5AcmVkaGF0LmNvbT4KICoKICogQXR0ZW1wdCB0byByZXByb2R1Y2UgdGhlIHhm
cyBpc3N1ZSB0aGF0IFpoZW55dSBvYnNlcnZlZC4KICogVGhlIGlkZWEgaXMgdG8gbWltaWMg
UUVNVSdzIGJlaGF2aW9yIHRvIGhhdmUgcHJpdmF0ZQogKiBtbWFwJ2VkIFZNQSBvbiB4ZnMg
ZmlsZSAoL3RtcC90ZXN0X2RhdGEpLiBUaGUgcHJvZ3JhbQogKiBzaG91bGQgYmUgcHV0IGlu
dG8gY2dyb3VwIHdoZXJlIHRoZSBtZW1vcnkgbGltaXQgaXMgc2V0LAogKiBzbyB0aGF0IG1l
bW9yeSBjbGFpbSBpcyBlbmZvcmNlZC4KICovCiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVk
ZSA8c3RkbGliLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgoj
aW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxzeXMvc3lz
Y2FsbC5oPgojaW5jbHVkZSA8c3lzL21tYW4uaD4KCiNkZWZpbmUgVEVTVF9GSUxFTkFNRQki
L3RtcC90ZXN0X2RhdGEiCiNkZWZpbmUgVEVTVF9NRU1fU0laRQkweDQwMDAwMDAwCgpzdGF0
aWMgdm9pZCBob2xkKGludCBhcmdjLCBjb25zdCBjaGFyICpkZXNjKQp7CglpbnQgb3B0OwoK
CWlmIChhcmdjIDw9IDEpCgkJcmV0dXJuOwoKCWZwcmludGYoc3Rkb3V0LCAiJXNcbiIsIGRl
c2MpOwoJc2NhbmYoIiVjIiwgJm9wdCk7Cn0KCQppbnQgbWFpbihpbnQgYXJnYywgY2hhciAq
KmFyZ3YpCnsKCWludCBmZCA9IDA7Cgl2b2lkICpidWYgPSAodm9pZCAqKS0xLCAqcDsKCWlu
dCBwZ3NpemUgPSBnZXRwYWdlc2l6ZSgpOwoJaW50IHJldDsKCglmZCA9IG9wZW4oVEVTVF9G
SUxFTkFNRSwgT19SRFdSKTsKCWlmIChmZCA8IDApIHsKCQlmcHJpbnRmKHN0ZGVyciwgIlVu
YWJsZSB0byBvcGVuIDwlcz5cbiIsIFRFU1RfRklMRU5BTUUpOwoJCXJldHVybiAtRUlPOwoJ
fQoKCWhvbGQoYXJnYywgIlByZXNzIGFueSBrZXkgdG8gbW1hcC4uLlxuIik7CglidWYgPSBt
bWFwKE5VTEwsIFRFU1RfTUVNX1NJWkUsIFBST1RfUkVBRCB8IFBST1RfV1JJVEUsCgkJICAg
TUFQX1BSSVZBVEUsIGZkLCAwKTsKCWlmIChidWYgPT0gKHZvaWQgKiktMSkgewoJCWZwcmlu
dGYoc3RkZXJyLCAiVW5hYmxlIHRvIG1tYXAgPCVzPlxuIiwgVEVTVF9GSUxFTkFNRSk7CgkJ
Z290byBjbGVhbnVwOwoJfQoKCWZwcmludGYoc3Rkb3V0LCAibW1hcCdlZCBhdCAweCVwXG4i
LCBidWYpOwoJcmV0ID0gbWFkdmlzZShidWYsIFRFU1RfTUVNX1NJWkUsIE1BRFZfSFVHRVBB
R0UpOwogICAgICAgIGlmIChyZXQpIHsKCQlmcHJpbnRmKHN0ZGVyciwgIlVuYWJsZSB0byBt
YWR2aXNlKE1BRFZfSFVHRVBBR0UpXG4iKTsKCQlnb3RvIGNsZWFudXA7Cgl9CgogICAgICAg
IGhvbGQoYXJnYywgIlByZXNzIGFueSBrZXkgdG8gcG9wdWxhdGUuLi4iKTsKICAgICAgICBm
cHJpbnRmKHN0ZG91dCwgIlBvcHVsYXRlIGFyZWEgYXQgMHglbHgsIHNpemU9MHgleFxuIiwK
ICAgICAgICAgICAgICAgICh1bnNpZ25lZCBsb25nKWJ1ZiwgVEVTVF9NRU1fU0laRSk7Cgly
ZXQgPSBtYWR2aXNlKGJ1ZiwgVEVTVF9NRU1fU0laRSwgTUFEVl9QT1BVTEFURV9XUklURSk7
CglpZiAocmV0KSB7CgkJZnByaW50ZihzdGRlcnIsICJVbmFibGUgdG8gbWFkdmlzZShNQURW
X1BPUFVMQVRFX1dSSVRFKVxuIik7CgkJZ290byBjbGVhbnVwOwoJfQoJCmNsZWFudXA6Cglo
b2xkKGFyZ2MsICJQcmVzcyBhbnkga2V5IHRvIG11bm1hcC4uLiIpOwoJaWYgKGJ1ZiAhPSAo
dm9pZCAqKS0xKQoJCW11bm1hcChidWYsIFRFU1RfTUVNX1NJWkUpOwoJaG9sZChhcmdjLCAi
UHJlc3MgYW55IGtleSB0byBjbG9zZS4uLiIpOwoJaWYgKGZkID4gMCkKCQljbG9zZShmZCk7
CgoJaG9sZChhcmdjLCAiUHJlc3MgYW55IGtleSB0byBleGl0Li4uIik7CglyZXR1cm4gMDsK
fQo=

--------------NVL90zIkYN4W03Myqjnk9mJs--

