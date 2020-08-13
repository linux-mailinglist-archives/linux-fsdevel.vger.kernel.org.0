Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CB5243B33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 16:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgHMOEV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 10:04:21 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41532 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgHMOEU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 10:04:20 -0400
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id 034C020B4908;
        Thu, 13 Aug 2020 07:04:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 034C020B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597327459;
        bh=0o/tDcek5PuEa2pxXB2PA3cbNFGUQi/hGYiJ8ibqWyU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lvoYtVAAPFSMeYex1kEUrFn9hM+XwFoYuDCVTMJPYhLukLLadgXPk5xzPEuc/GT2+
         XemgykeTtZUJFE9NNrriE2ahzsf5lRPPG/0XIQ8dkz9MF8vPAt1D6BOqJmPxoyF47P
         q/F2ZK8/GINbFqT1aVYsh4Lz0sgP5SftJdAF8TjQ=
Subject: Re: [PATCH v2 1/4] selinux: Create function for selinuxfs directory
 cleanup
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20200812191525.1120850-1-dburgener@linux.microsoft.com>
 <20200812191525.1120850-2-dburgener@linux.microsoft.com>
 <CAEjxPJ61+Dusa-i_uggdGDQ-3iGb7+JDJkbsC48DpKpx_gEJSA@mail.gmail.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
Message-ID: <27f58aaf-467c-f804-f6a0-d3bdab7e3c25@linux.microsoft.com>
Date:   Thu, 13 Aug 2020 10:04:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ61+Dusa-i_uggdGDQ-3iGb7+JDJkbsC48DpKpx_gEJSA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/12/20 3:21 PM, Stephen Smalley wrote:
> On Wed, Aug 12, 2020 at 3:15 PM Daniel Burgener
> <dburgener@linux.microsoft.com> wrote:
>> Separating the cleanup from the creation will simplify two things in
>> future patches in this series.  First, the creation can be made generic,
>> to create directories not tied to the selinux_fs_info structure.  Second,
>> we will ultimately want to reorder creation and deletion so that the
>> deletions aren't performed until the new directory structures have already
>> been moved into place.
>>
>> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
>> ---
>>   security/selinux/selinuxfs.c | 41 ++++++++++++++++++++++++------------
>>   1 file changed, 27 insertions(+), 14 deletions(-)
>>
>> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
>> index 131816878e50..fc914facb48f 100644
>> --- a/security/selinux/selinuxfs.c
>> +++ b/security/selinux/selinuxfs.c
>> @@ -355,6 +355,9 @@ static int sel_make_classes(struct selinux_fs_info *fsi,
>>   static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
>>                          unsigned long *ino);
>>
>> +/* declaration for sel_remove_old_policy_nodes */
>> +static void sel_remove_entries(struct dentry *de);
>> +
>>   static ssize_t sel_read_mls(struct file *filp, char __user *buf,
>>                                  size_t count, loff_t *ppos)
>>   {
>> @@ -509,11 +512,35 @@ static const struct file_operations sel_policy_ops = {
>>          .llseek         = generic_file_llseek,
>>   };
>>
>> +static void sel_remove_old_policy_nodes(struct selinux_fs_info *fsi)
>> +{
>> +       u32 i;
>> +
>> +       /* bool_dir cleanup */
>> +       for (i = 0; i < fsi->bool_num; i++)
>> +               kfree(fsi->bool_pending_names[i]);
>> +       kfree(fsi->bool_pending_names);
>> +       kfree(fsi->bool_pending_values);
>> +       fsi->bool_num = 0;
>> +       fsi->bool_pending_names = NULL;
>> +       fsi->bool_pending_values = NULL;
>> +
>> +       sel_remove_entries(fsi->bool_dir);
>> +
>> +       /* class_dir cleanup */
>> +       sel_remove_entries(fsi->class_dir);
>> +
>> +       /* policycap_dir cleanup */
>> +       sel_remove_entries(fsi->policycap_dir);
> This one shouldn't have its entries removed anymore.

Yes, you're right.  This didn't come up in my testing because this part 
of the function gets removed in the fourth patch in the series anyways.  
Given that most of this patch actually gets lost in the fourth patch, 
that's probably an indication that I should rethink having this patch in 
the series at all.  I'll come up with something cleaner for version 2.

-Daniel

