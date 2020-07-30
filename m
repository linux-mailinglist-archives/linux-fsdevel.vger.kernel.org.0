Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE032332E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 15:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgG3NW2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 09:22:28 -0400
Received: from relay.sw.ru ([185.231.240.75]:49368 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726281AbgG3NW2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:22:28 -0400
Received: from [192.168.15.64]
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k18Vc-0003gl-2Y; Thu, 30 Jul 2020 16:22:08 +0300
Subject: Re: [PATCH 11/23] fs: Add /proc/namespaces/ directory
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     viro@zeniv.linux.org.uk, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <159611041929.535980.14513096920129728440.stgit@localhost.localdomain>
 <20200730121834.GA4490@localhost.localdomain>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <44de5acb-6da3-e742-6472-4f9cbe3051e2@virtuozzo.com>
Date:   Thu, 30 Jul 2020 16:22:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730121834.GA4490@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30.07.2020 15:18, Alexey Dobriyan wrote:
> On Thu, Jul 30, 2020 at 03:00:19PM +0300, Kirill Tkhai wrote:
> 
>> # ls /proc/namespaces/ -l
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'cgroup:[4026531835]' -> 'cgroup:[4026531835]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'ipc:[4026531839]' -> 'ipc:[4026531839]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026531840]' -> 'mnt:[4026531840]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026531861]' -> 'mnt:[4026531861]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532133]' -> 'mnt:[4026532133]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532134]' -> 'mnt:[4026532134]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532135]' -> 'mnt:[4026532135]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532136]' -> 'mnt:[4026532136]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'net:[4026531993]' -> 'net:[4026531993]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'pid:[4026531836]' -> 'pid:[4026531836]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'time:[4026531834]' -> 'time:[4026531834]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'user:[4026531837]' -> 'user:[4026531837]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'uts:[4026531838]' -> 'uts:[4026531838]'
> 
> I'd say make it '%s-%llu'. The brackets don't carry any information.
> And ':' forces quoting with recent coreutils.
> 
>> +static int parse_namespace_dentry_name(const struct dentry *dentry,
>> +		const char **type, unsigned int *type_len, unsigned int *inum)
>> +{
>> +	const char *p, *name;
>> +	int count;
>> +
>> +	*type = name = dentry->d_name.name;
>> +	p = strchr(name, ':');
>> +	*type_len = p - name;
>> +	if (!p || p == name)
>> +		return -ENOENT;
>> +
>> +	p += 1;
>> +	if (sscanf(p, "[%u]%n", inum, &count) != 1 || *(p + count) != '\0' ||
>> +	    *inum < PROC_NS_MIN_INO)
>> +		return -ENOENT;
> 
> sscanf is banned from lookup code due to lax whitespace rules.
> See
> 
> 	commit ac7f1061c2c11bb8936b1b6a94cdb48de732f7a4
> 	proc: fix /proc/*/map_files lookup

Ok, thanks for pointing this.

> Of course someone sneaked in 1 instance, yikes.
> 
> 	$ grep -e scanf -n -r fs/proc/
> 	fs/proc/base.c:1596:            err = sscanf(pos, "%9s %lld %lu", clock,
> 
>> +static int proc_namespaces_readdir(struct file *file, struct dir_context *ctx)
> 
>> +		len = snprintf(name, sizeof(name), "%s:[%u]", ns->ops->name, inum);
> 
> [] -- no need.
> 

