Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A74557FF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 18:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiFWQgY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 12:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiFWQgW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:36:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F72C42A1D;
        Thu, 23 Jun 2022 09:36:21 -0700 (PDT)
Received: from localhost (modemcable141.102-20-96.mc.videotron.ca [96.20.102.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: krisman)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8888066017DF;
        Thu, 23 Jun 2022 17:36:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656002179;
        bh=xBl8A27Ms8S+5lzaIzajGkuNErZevkNTF10THb9C3M0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=G3xyWOp1DA3bCpt0o339Cuq7jQstFFo+ddrZn4agrJrh/RHmxxyGzPqEZsgRw7DEb
         lzyw80VcZ5txS+ka5g+VuLOz0fAL2mdPORc7tg5Uy0Yzgn8knfZEGFW4dPy4mbtnrX
         MVQb1C0C6LDhDlyBBa7mtUgjyQRfmBMysO2ug4p+Oc8cTykyCOG0rz0v+Qbiuvhl3a
         NxpD17y570G38p9Xf8iMTQMGY1bePhas7Sd5NNLKG1vLGAaKuAtbijkKAnhcL49EEy
         y7mQqqIYQ9mvd/skaUkR8cxmTSSFP8mZs7frOmFzp6120DMVXoWkzFLKVbugb8y3Ec
         bUXX+Xaag5rMw==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     kernel test robot <lkp@intel.com>
Cc:     viro@zeniv.linux.org.uk, tytso@mit.edu, jaegeuk@kernel.org,
        kbuild-all@lists.01.org, ebiggers@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel@collabora.com
Subject: Re: [PATCH 6/7] ext4: Enable negative dentries on case-insensitive
 lookup
Organization: Collabora
References: <20220622194603.102655-7-krisman@collabora.com>
        <202206231550.0JrilBjp-lkp@intel.com>
Date:   Thu, 23 Jun 2022 12:36:15 -0400
In-Reply-To: <202206231550.0JrilBjp-lkp@intel.com> (kernel test robot's
        message of "Thu, 23 Jun 2022 15:29:07 +0800")
Message-ID: <875ykr2v7k.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> Hi Gabriel,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on tytso-ext4/dev]
> [also build test ERROR on jaegeuk-f2fs/dev-test linus/master v5.19-rc3 next-20220622]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Gabriel-Krisman-Bertazi/Support-negative-dentries-on-case-insensitive-directories/20220623-034942
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> config: x86_64-randconfig-a006 (https://download.01.org/0day-ci/archive/20220623/202206231550.0JrilBjp-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/69488ccc517a48af2f1cec0efb84651397edf6f6
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Gabriel-Krisman-Bertazi/Support-negative-dentries-on-case-insensitive-directories/20220623-034942
>         git checkout 69488ccc517a48af2f1cec0efb84651397edf6f6
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
>>> ERROR: modpost: "d_set_casefold_lookup" [fs/ext4/ext4.ko] undefined!

Hm, missing the EXPORT_SYMBOL() since this is called from filesystems.
I will add it for v2.

-- 
Gabriel Krisman Bertazi
