Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1EC21FDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 23:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfEQVrw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 17:47:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36081 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727698AbfEQVrw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 17:47:52 -0400
Received: from tazenda.hos.anvin.org (c-73-231-201-241.hsd1.ca.comcast.net [73.231.201.241])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x4HLlV7V1523285
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 17 May 2019 14:47:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x4HLlV7V1523285
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558129653;
        bh=6m6P7/7wp6GtKHtVUbHmjwndqWiC/ZVOfzP9uWP7gHI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=stImGMuT2eF+/pWQt8ipj1aA1HkK0oQkkq+agmFDgZDBJ3o1MdV1rQ4dldfRTrSbu
         tJW3gxn1IqsEvIMs6LXDwETjBN2N+OvejcnhOAHjHqeFVcdaqJgWyZpwHf566RSMXz
         /8ToU9q2Cm0gaNCYpLV+Ne8Y9gDnwdrhhbmNYJeX1ZqETiF+AvaK/ap6eu9Um1ynyR
         xY19HQWIterstp/KubRTn8WFkwAVDhEjgzAln1knF792Ac1IznnVWk0GwbT/ThrcUQ
         XQ1uyn+6o7+qbHKG0IBApl9VOxozWQf5BVPsZDzgVbBMWpctYvfiPgkUi1+F/DxcGF
         DqCW3Tj5dMWUA==
Subject: Re: [PATCH v3 2/2] initramfs: introduce do_readxattrs()
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>, viro@zeniv.linux.org.uk,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, arnd@arndb.de,
        rob@landley.net, james.w.mcmechan@gmail.com, niveditas98@gmail.com
References: <20190517165519.11507-1-roberto.sassu@huawei.com>
 <20190517165519.11507-3-roberto.sassu@huawei.com>
 <CD9A4F89-7CA5-4329-A06A-F8DEB87905A5@zytor.com>
 <20190517210219.GA5998@rani.riverdale.lan>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <d48f35a1-aab1-2f20-2e91-5e81a84b107f@zytor.com>
Date:   Fri, 17 May 2019 14:47:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517210219.GA5998@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/17/19 2:02 PM, Arvind Sankar wrote:
> On Fri, May 17, 2019 at 01:18:11PM -0700, hpa@zytor.com wrote:
>>
>> Ok... I just realized this does not work for a modular initramfs, composed at load time from multiple files, which is a very real problem. Should be easy enough to deal with: instead of one large file, use one companion file per source file, perhaps something like filename..xattrs (suggesting double dots to make it less likely to conflict with a "real" file.) No leading dot, as it makes it more likely that archivers will sort them before the file proper.
> This version of the patch was changed from the previous one exactly to deal with this case --
> it allows for the bootloader to load multiple initramfs archives, each
> with its own .xattr-list file, and to have that work properly.
> Could you elaborate on the issue that you see?
> 

Well, for one thing, how do you define "cpio archive", each with its own
.xattr-list file? Second, that would seem to depend on the ordering, no,
in which case you depend critically on .xattr-list file following the
files, which most archivers won't do.

Either way it seems cleaner to have this per file; especially if/as it
can be done without actually mucking up the format.

I need to run, but I'll post a more detailed explanation of what I did
in a little bit.

	-hpa

