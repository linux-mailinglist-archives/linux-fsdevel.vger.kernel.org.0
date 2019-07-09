Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0874D63AF0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 20:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfGIS2B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 14:28:01 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:39565 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGIS2B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:28:01 -0400
Received: by mail-io1-f44.google.com with SMTP id f4so29766288ioh.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jul 2019 11:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=Ys1tExUXnGuHx8mMvauSevz/cEht+mA14Kwl4w2Pkgw=;
        b=n7M07cSM57J43wmXSptJW0h23FDbdLBNfgOY3GXy8apjXAgyQVk7XoQt5ZaH5j4b2q
         SR07R21oEchFeZca5/Px2wFoHHW+k4iS8kF/r5RH6I28MZeRu6PwR51nbMWIaSSKW3pS
         iV5w0eIla2AZrTsdzBcVNfQninRssaQqBg9pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=Ys1tExUXnGuHx8mMvauSevz/cEht+mA14Kwl4w2Pkgw=;
        b=ICNfnT8gaSj336+evh5ctgro2J7oGPxKdKV1UAEwtZdL67PhUT76q4TNi/M48ZA4K2
         ldkb84l+/csTthNYGzYDDfb967PZjgAtUuzXRYjbl9ILdoNc5WW8wDkG82n0aKBbv0kU
         FpG7dR/LPpnGwqy+vBV4Cmj0pccU5MotzJE9SnrOdwF/AvJBMBewK3AoQveFbNXYePFo
         rtvCszfqZi+0Hv6U3yqLNkrk5oQBpDw5DrN9/0HjaDFtEcgSJUXLf4fT2ubcm3LdEvF2
         iVJyYg40Dsd8JQXw7plGYBrJ/44rUKDSSxn973aeJZcXPzEefhpnXhIkZYeUid6dzbQU
         WUtg==
X-Gm-Message-State: APjAAAU77FmJZVYoDC/BYD/Ll8vYTxnaVmrREoeEn+guMgCdqz78v6rR
        0M1tSv5yx0Cpj1lim+UxmOK5iA==
X-Google-Smtp-Source: APXvYqwggVBc6dkzGd+FN3uEMd8GyEsCpYlkbc9X79mVnUFMVz5cBz+cpxtVvT+5YxaLD8rgXcE08w==
X-Received: by 2002:a5d:8c87:: with SMTP id g7mr27016585ion.85.1562696880133;
        Tue, 09 Jul 2019 11:28:00 -0700 (PDT)
Received: from [10.10.3.1] (104-51-28-62.lightspeed.cicril.sbcglobal.net. [104.51.28.62])
        by smtp.googlemail.com with ESMTPSA id j1sm18257487iop.14.2019.07.09.11.27.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 11:27:59 -0700 (PDT)
To:     Jan Kara <jack@suse.cz>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Steve Magnani <steve.magnani@digidescorp.com>
Subject: [RFC] udf: 2.01 interoperability issues with Windows 10
Message-ID: <96e1ea00-ac12-015d-5c54-80a83f08b898@digidescorp.com>
Date:   Tue, 9 Jul 2019 13:27:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Recently I have been exploring Advanced Format (4K sector size)
and high capacity aspects of UDF 2.01 support in Linux and
Windows 10. I thought it might be helpful to summarize my findings.

The good news is that I did not see any bugs in the Linux
ecosystem (kernel driver + mkudffs).

The not-so-good news is that Windows has some issues that affect
interoperability. One of my goals in posting this is to open a
discussion on whether changes should be made in the Linux UDF
ecosystem to accommodate these quirks.

My test setup includes the following software components:

* mkudffs 1.3 and 2.0
* kernel 4.15.0-43 and 4.15.0-52
* Windows 10 1803 17134.829
* chkdsk 10.0.17134.1
* udfs.sys 10.0.17134.648


ISSUE 1: Inability of the Linux UDF driver to mount 4K-sector
          media formatted by Windows.

This is because the Windows ecosystem mishandles the ECMA-167
corner case that requires Volume Recognition Sequence components
to be placed at 4K intervals on 4K-sector media, instead of the
2K intervals required with smaller sectors. The Linux UDF driver
emits the following when presented with Windows-formatted media:

   UDF-fs: warning (device sdc1): udf_load_vrs: No VRS found
   UDF-fs: Scanning with blocksize 4096 failed

A hex dump of the VRS written by the Windows 10 'format' utility
yields this:

   0000: 00 42 45 41 30 31 01 00 00 00 00 00 00 00 00 00  .BEA01..........
   0800: 00 4e 53 52 30 33 01 00 00 00 00 00 00 00 00 00  .NSR03..........
   1000: 00 54 45 41 30 31 01 00 00 00 00 00 00 00 00 00  .TEA01..........

We may want to consider tweaking the kernel UDF driver to
tolerate this quirk; if so a question is whether that should be
done automatically, only in response to a mount option or
module parameter, or only with some subsequent confirmation
that the medium was formatted by Windows.


ISSUE 2: Inability of Windows chkdsk to analyze 4K-sector media
          formatted by mkudffs.

This is another aspect of Windows' VRS corner case bug.
Formatting by mkudffs places the VRS components at the proper 4K
intervals. But the chkdsk utility looks for components at 2K
intervals. Not finding a component at byte offset 2048, chkdsk
decides that the media is RAW and cannot be checked. Note that
this bug affects chkdsk only; udfs.sys *does* recognize mkudffs-
formatted 4K-sector media and is able to mount it.

It would be possible to work around this by tweaking mkudffs to
insert dummy BOOT2 components in between the BEA/NSR/TEA:

   0000: 00 42 45 41 30 31 01 00 00 00 00 00 00 00 00 00  .BEA01..........
   0800: 00 42 4f 4f 54 32 01 00 00 00 00 00 00 00 00 00  .BOOT2..........
   1000: 00 4e 53 52 30 33 01 00 00 00 00 00 00 00 00 00  .NSR03..........
   1800: 00 42 4f 4f 54 32 01 00 00 00 00 00 00 00 00 00  .BOOT2..........
   2000: 00 54 45 41 30 31 01 00 00 00 00 00 00 00 00 00  .TEA01..........

That would introduce a slight ECMA-167 nonconformity, but Linux
does not object and Windows actually performs better. I would
have to tweak udffsck though since I believe this could confuse
its automatic detection of medium block size.


ISSUE 3: Inability of the Windows UDF driver to mount media
          read-write when a maximally-sized space bitmap
          descriptor is present

I suspect this is an off-by-one error in udfs.sys relating to
the maximum number of blocks a space bitmap descriptor can
occupy. The bug causes UDF partitions that are close to 2 TiB
(512-sector media) or 16 TiB (4K-sector media) to be mounted
read-only, with no user-visible indication as to why.

It would be possible for mkudffs to print a warning when
formatting results in a space bitmap that occupies the maximum
number of blocks.


ISSUE 4: chkdsk reports spurious errors when space bitmap
          descriptor exceeds 32 MiB

Some permutations of this:

   * "Correcting errors in Space Bitmap Descriptor at block 0"
     (with no prior mention of any errors)
   * "Space Bitmap Descriptor at block 32 is corrupt or unreadable"

This is actually one of the more crippling issues if one values
Windows' ability to check and repair UDF errors. A limit of
32 MiB on the space bitmap implies a UDF partition size of at
most 137 GB (not GiB) with 512-sector media or at most 1099 GB
with 4K-sector media.

Again, the most I think we could do is code mkudffs to warn of
this possibility. But a message that clearly conveys the issue
and what should be done to avoid it could be a little tricky to
construct.


Obviously the best solution would be for the Windows bugs to
get fixed. If anyone reading this can convey these details into
the Microsoft silo, that would be great.

Regards,
------------------------------------------------------------------------
  Steven J. Magnani               "I claim this network for MARS!
  www.digidescorp.com              Earthling, return my space modulator!"

  #include <standard.disclaimer>

