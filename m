Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB6C3D2764
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 18:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhGVPfH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 11:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhGVPfG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 11:35:06 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D42FC061757;
        Thu, 22 Jul 2021 09:15:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id F399C1F44551
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        kernel test robot <lkp@intel.com>, amir73il@gmail.com,
        kbuild-all@lists.01.org, djwong@kernel.org, tytso@mit.edu,
        david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 14/15] samples: Add fs error monitoring example
Organization: Collabora
References: <20210629191035.681913-15-krisman@collabora.com>
        <202106301048.BainWUsk-lkp@intel.com> <87mtqicqux.fsf@collabora.com>
        <20210720194955.GH25548@kadam>
        <4313fff4-343a-2937-3a97-c5da860827b1@intel.com>
Date:   Thu, 22 Jul 2021 12:15:35 -0400
In-Reply-To: <4313fff4-343a-2937-3a97-c5da860827b1@intel.com> (Rong A. Chen's
        message of "Thu, 22 Jul 2021 20:54:36 +0800")
Message-ID: <874kcmb9zs.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Chen, Rong A" <rong.a.chen@intel.com> writes:

> Hi Gabriel,
>
> On 7/21/2021 3:49 AM, Dan Carpenter wrote:
>> On Mon, Jul 19, 2021 at 10:36:54AM -0400, Gabriel Krisman Bertazi
>> wrote:
>>> kernel test robot <lkp@intel.com> writes:
>>>
>>>> Hi Gabriel,
>>>>
>>>> I love your patch! Yet something to improve:
>>>>
>>>> [auto build test ERROR on ext3/fsnotify]
>>>> [also build test ERROR on ext4/dev linus/master v5.13 next-20210629]
>>>> [cannot apply to tytso-fscrypt/master]
>>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>>> And when submitting patch, we suggest to use '--base' as documented in
>>>> https://git-scm.com/docs/git-format-patch ]
>>>>
>>>> url:    https://github.com/0day-ci/linux/commits/Gabriel-Krisman-Bertazi/File-system-wide-monitoring/20210630-031347
>>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git  fsnotify
>>>> config: arm64-allyesconfig (attached as .config)
>>>> compiler: aarch64-linux-gcc (GCC) 9.3.0
>>>> reproduce (this is a W=1 build):
>>>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross  -O ~/bin/make.cross
>>>>          chmod +x ~/bin/make.cross
>>>>          # https://github.com/0day-ci/linux/commit/746524d8db08a041fed90e41b15c8e8ca69cb22d
>>>>          git remote add linux-review https://github.com/0day-ci/linux
>>>>          git fetch --no-tags linux-review Gabriel-Krisman-Bertazi/File-system-wide-monitoring/20210630-031347
>>>>          git checkout 746524d8db08a041fed90e41b15c8e8ca69cb22d
>>>>          # save the attached .config to linux build tree
>>>>          mkdir build_dir
>>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash samples/
>>>>
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> All errors (new ones prefixed by >>):
>>>>
>>>>>> samples/fanotify/fs-monitor.c:7:10: fatal error: errno.h: No such file or directory
>>>>         7 | #include <errno.h>
>>>>           |          ^~~~~~~~~
>>>>     compilation terminated.
>>>
>>> Hi Dan,
>>>
>>> I'm not sure what's the proper fix here.  Looks like 0day is not using
>>> cross system libraries when building this user space code.  Should I do
>>> something special to silent it?
>
> It seems need extra libraries for arm64, we'll disable CONFIG_SAMPLES to
> avoid reporting this error.

There are kernel space code in samples/ that still benefit from the test
robot. See ftrace/ftrace-direct-too.c for one instance.

Perhaps it can be disabled just for userprogs-* Makefile entries in
samples/ ?

-- 
Gabriel Krisman Bertazi
