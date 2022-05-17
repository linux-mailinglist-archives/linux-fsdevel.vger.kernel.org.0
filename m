Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28A552A0BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 13:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343670AbiEQLuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 07:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345448AbiEQLuU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 07:50:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AF0228706
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 May 2022 04:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652788216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=InDl4lj3JoQ7ge8IuksQfrdoY0Vz20hxoE4piMGP3sM=;
        b=VDO6aJV0texNJC3vpE5OZikpSm7mVZndzLpfxd3l9qvSSDvQr/8pJO9vXGhA4PpjV9qSRF
        ezvnyAEBavT3Ndu0HIk8oatZyHpL16QUhN/wky93ffkUAWBT62VH9uEqOyHxUFp7NKm1ZB
        MlAhOZDTnu0AXgqufK1iolLZxrexhWs=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-m2SrZh8IO92MqRjSkQw18Q-1; Tue, 17 May 2022 07:50:14 -0400
X-MC-Unique: m2SrZh8IO92MqRjSkQw18Q-1
Received: by mail-pf1-f200.google.com with SMTP id c4-20020aa79524000000b005180f331899so381583pfp.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 May 2022 04:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=InDl4lj3JoQ7ge8IuksQfrdoY0Vz20hxoE4piMGP3sM=;
        b=6UW2iyvNrfEQhIgUVtBqURfMfXFRBYfyw1tHRCckgU2lrBp/Ty+cU5Id8YmKWikOFO
         gvJZaofi3VIQq1HKd6ZlOi5FDuhc39r5UA9nX8TsPgsjLdL/5aQBYhoV7MmalOrpOq7W
         ub+6xvkRyGu3HQdUDnVZ/JBZcbaSHRnCWCy8FtCQ/nMMUODVlCImpDEFO7b3aorMS44g
         9CEF2vXjUeHsTSneYTcFL6IttYxztzYhN7cqg7+jwMgU3HESHZPMtd+XGeKyyQbe06q5
         x00Y0fEUokmuydE7vN01SLnfS9AbAi5mOb9Nww1ZVMupY/ra7SL81Qkaxf9ANzVJPEBi
         H5gg==
X-Gm-Message-State: AOAM532rp7aGgkE8HmZQ2SuFaxgaOT8iyFaUBuR8Xjb2NVaC1DMxkp5T
        R5UhR49Z9rp83sEUFRMUCYWS1RhtrAdv3EzclGB+un4qEw4GW6/awS+UAtgaPD+LhMVdx9GKNzl
        kFyzZCWfbs6A+UnNg7dVLC00kQw==
X-Received: by 2002:a05:6a02:208:b0:3c6:9898:e656 with SMTP id bh8-20020a056a02020800b003c69898e656mr19604048pgb.560.1652788213491;
        Tue, 17 May 2022 04:50:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLaq699zWzg4OvovTAw1g2tp09TI3W13a2SZ/7iZR5LE+uGT28yH71USeaTCmti4ScEYSgeQ==
X-Received: by 2002:a05:6a02:208:b0:3c6:9898:e656 with SMTP id bh8-20020a056a02020800b003c69898e656mr19604019pgb.560.1652788213114;
        Tue, 17 May 2022 04:50:13 -0700 (PDT)
Received: from [10.72.12.136] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y5-20020a1709027c8500b0016141e6c5acsm6985559pll.296.2022.05.17.04.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 04:50:12 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] ceph: wait the first reply of inflight
 unlink/rmdir
To:     Jeff Layton <jlayton@kernel.org>, viro@zeniv.linux.org.uk
Cc:     idryomov@gmail.com, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, arnd@arndb.de, mcgrof@kernel.org,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20220517010316.81483-1-xiubli@redhat.com>
 <20220517010316.81483-3-xiubli@redhat.com>
 <a2d05d80e30831e915e707a48520139500befc2b.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <bce4ef40-277f-8bc0-6cdb-3435eddddf44@redhat.com>
Date:   Tue, 17 May 2022 19:49:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <a2d05d80e30831e915e707a48520139500befc2b.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/17/22 7:35 PM, Jeff Layton wrote:
> On Tue, 2022-05-17 at 09:03 +0800, Xiubo Li wrote:
>> In async unlink case the kclient won't wait for the first reply
>> from MDS and just drop all the links and unhash the dentry and then
>> succeeds immediately.
>>
>> For any new create/link/rename,etc requests followed by using the
>> same file names we must wait for the first reply of the inflight
>> unlink request, or the MDS possibly will fail these following
>> requests with -EEXIST if the inflight async unlink request was
>> delayed for some reasons.
>>
>> And the worst case is that for the none async openc request it will
>> successfully open the file if the CDentry hasn't been unlinked yet,
>> but later the previous delayed async unlink request will remove the
>> CDenty. That means the just created file is possiblly deleted later
>> by accident.
>>
>> We need to wait for the inflight async unlink requests to finish
>> when creating new files/directories by using the same file names.
>>
>> URL: https://tracker.ceph.com/issues/55332
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   fs/ceph/dir.c        | 70 +++++++++++++++++++++++++++++++++++++++----
>>   fs/ceph/file.c       |  5 ++++
>>   fs/ceph/mds_client.c | 71 ++++++++++++++++++++++++++++++++++++++++++++
>>   fs/ceph/mds_client.h |  1 +
>>   fs/ceph/super.c      |  3 ++
>>   fs/ceph/super.h      | 19 ++++++++----
>>   6 files changed, 159 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>> index eae417d71136..88e0048d719e 100644
>> --- a/fs/ceph/dir.c
>> +++ b/fs/ceph/dir.c
>> @@ -856,6 +856,10 @@ static int ceph_mknod(struct user_namespace *mnt_userns, struct inode *dir,
>>   	if (ceph_snap(dir) != CEPH_NOSNAP)
>>   		return -EROFS;
>>   
>> +	err = ceph_wait_on_conflict_unlink(dentry);
>> +	if (err)
>> +		return err;
>> +
>>   	if (ceph_quota_is_max_files_exceeded(dir)) {
>>   		err = -EDQUOT;
>>   		goto out;
>> @@ -918,6 +922,10 @@ static int ceph_symlink(struct user_namespace *mnt_userns, struct inode *dir,
>>   	if (ceph_snap(dir) != CEPH_NOSNAP)
>>   		return -EROFS;
>>   
>> +	err = ceph_wait_on_conflict_unlink(dentry);
>> +	if (err)
>> +		return err;
>> +
>>   	if (ceph_quota_is_max_files_exceeded(dir)) {
>>   		err = -EDQUOT;
>>   		goto out;
>> @@ -968,9 +976,13 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>>   	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
>>   	struct ceph_mds_request *req;
>>   	struct ceph_acl_sec_ctx as_ctx = {};
>> -	int err = -EROFS;
>> +	int err;
>>   	int op;
>>   
>> +	err = ceph_wait_on_conflict_unlink(dentry);
>> +	if (err)
>> +		return err;
>> +
>>   	if (ceph_snap(dir) == CEPH_SNAPDIR) {
>>   		/* mkdir .snap/foo is a MKSNAP */
>>   		op = CEPH_MDS_OP_MKSNAP;
>> @@ -980,6 +992,7 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>>   		dout("mkdir dir %p dn %p mode 0%ho\n", dir, dentry, mode);
>>   		op = CEPH_MDS_OP_MKDIR;
>>   	} else {
>> +		err = -EROFS;
>>   		goto out;
>>   	}
>>   
>> @@ -1037,6 +1050,10 @@ static int ceph_link(struct dentry *old_dentry, struct inode *dir,
>>   	struct ceph_mds_request *req;
>>   	int err;
>>   
>> +	err = ceph_wait_on_conflict_unlink(dentry);
>> +	if (err)
>> +		return err;
>> +
>>   	if (ceph_snap(dir) != CEPH_NOSNAP)
>>   		return -EROFS;
>>   
>> @@ -1071,9 +1088,27 @@ static int ceph_link(struct dentry *old_dentry, struct inode *dir,
>>   static void ceph_async_unlink_cb(struct ceph_mds_client *mdsc,
>>   				 struct ceph_mds_request *req)
>>   {
>> +	struct dentry *dentry = req->r_dentry;
>> +	struct ceph_fs_client *fsc = ceph_sb_to_client(dentry->d_sb);
>> +	struct ceph_dentry_info *di = ceph_dentry(dentry);
>>   	int result = req->r_err ? req->r_err :
>>   			le32_to_cpu(req->r_reply_info.head->result);
>>   
>> +	if (test_bit(CEPH_DENTRY_ASYNC_UNLINK_BIT, &di->flags)) {
> Shouldn't this bit always be set in this case? Maybe this should be a
> WARN_ON ?

Okay, maybe a pr_warn() as you mentioned below.


>
>> +		BUG_ON(req->r_op != CEPH_MDS_OP_UNLINK);
> Note that this will crash the box in some environments (e.g. RHEL
> kernels). I really advise against adding new BUG_ON calls unless the
> situation is so dire that the machine can't (or shouldn't) continue on.
>
> In this case, we got a bogus reply from the MDS. I think throwing a
> pr_warn message and erroring out the unlink would be better.

Makes sense.


>> +
>> +		spin_lock(&fsc->async_unlink_conflict_lock);
>> +		hash_del_rcu(&di->hnode);
>> +		spin_unlock(&fsc->async_unlink_conflict_lock);
>> +
>> +		spin_lock(&dentry->d_lock);
>> +		di->flags &= ~CEPH_DENTRY_ASYNC_UNLINK;
>> +		wake_up_bit(&di->flags, CEPH_DENTRY_ASYNC_UNLINK_BIT);
>> +		spin_unlock(&dentry->d_lock);
>> +
>> +		synchronize_rcu();
> Why do you need to synchronize_rcu here?
>
> I guess the concern is that once we put the req, then it could put the
> dentry and free di while someone is still walking the hash?

Yeah, right, we just need to make sure while iterating the hashtable the 
di memory won't be released after this.

>> +	}
>> +
>>   	if (result == -EJUKEBOX)
>>   		goto out;
>>   
>> @@ -1081,7 +1116,7 @@ static void ceph_async_unlink_cb(struct ceph_mds_client *mdsc,
>>   	if (result) {
>>   		int pathlen = 0;
>>   		u64 base = 0;
>> -		char *path = ceph_mdsc_build_path(req->r_dentry, &pathlen,
>> +		char *path = ceph_mdsc_build_path(dentry, &pathlen,
>>   						  &base, 0);
>>   
>>   		/* mark error on parent + clear complete */
>> @@ -1089,13 +1124,13 @@ static void ceph_async_unlink_cb(struct ceph_mds_client *mdsc,
>>   		ceph_dir_clear_complete(req->r_parent);
>>   
>>   		/* drop the dentry -- we don't know its status */
>> -		if (!d_unhashed(req->r_dentry))
>> -			d_drop(req->r_dentry);
>> +		if (!d_unhashed(dentry))
>> +			d_drop(dentry);
>>   
>>   		/* mark inode itself for an error (since metadata is bogus) */
>>   		mapping_set_error(req->r_old_inode->i_mapping, result);
>>   
>> -		pr_warn("ceph: async unlink failure path=(%llx)%s result=%d!\n",
>> +		pr_warn("async unlink failure path=(%llx)%s result=%d!\n",
>>   			base, IS_ERR(path) ? "<<bad>>" : path, result);
>>   		ceph_mdsc_free_path(path, pathlen);
>>   	}
>> @@ -1180,6 +1215,8 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
>>   
>>   	if (try_async && op == CEPH_MDS_OP_UNLINK &&
>>   	    (req->r_dir_caps = get_caps_for_async_unlink(dir, dentry))) {
>> +		struct ceph_dentry_info *di = ceph_dentry(dentry);
>> +
>>   		dout("async unlink on %llu/%.*s caps=%s", ceph_ino(dir),
>>   		     dentry->d_name.len, dentry->d_name.name,
>>   		     ceph_cap_string(req->r_dir_caps));
>> @@ -1187,6 +1224,16 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
>>   		req->r_callback = ceph_async_unlink_cb;
>>   		req->r_old_inode = d_inode(dentry);
>>   		ihold(req->r_old_inode);
>> +
>> +		spin_lock(&dentry->d_lock);
>> +		di->flags |= CEPH_DENTRY_ASYNC_UNLINK;
>> +		spin_unlock(&dentry->d_lock);
>> +
>> +		spin_lock(&fsc->async_unlink_conflict_lock);
>> +		hash_add_rcu(fsc->async_unlink_conflict, &di->hnode,
>> +			     dentry->d_name.hash);
>> +		spin_unlock(&fsc->async_unlink_conflict_lock);
>> +
>>   		err = ceph_mdsc_submit_request(mdsc, dir, req);
>>   		if (!err) {
>>   			/*
>> @@ -1198,6 +1245,15 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
>>   		} else if (err == -EJUKEBOX) {
>>   			try_async = false;
>>   			ceph_mdsc_put_request(req);
>> +
>> +			spin_lock(&dentry->d_lock);
>> +			di->flags &= ~CEPH_DENTRY_ASYNC_UNLINK;
>> +			spin_unlock(&dentry->d_lock);
>> +
>> +			spin_lock(&fsc->async_unlink_conflict_lock);
>> +			hash_del_rcu(&di->hnode);
>> +			spin_unlock(&fsc->async_unlink_conflict_lock);
>> +
>>   			goto retry;
>>   		}
>>   	} else {
>> @@ -1237,6 +1293,10 @@ static int ceph_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>>   	    (!ceph_quota_is_same_realm(old_dir, new_dir)))
>>   		return -EXDEV;
>>   
>> +	err = ceph_wait_on_conflict_unlink(new_dentry);
>> +	if (err)
>> +		return err;
>> +
>>   	dout("rename dir %p dentry %p to dir %p dentry %p\n",
>>   	     old_dir, old_dentry, new_dir, new_dentry);
>>   	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>> index 8c8226c0feac..47d068e6436a 100644
>> --- a/fs/ceph/file.c
>> +++ b/fs/ceph/file.c
>> @@ -740,6 +740,10 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
>>   	if (dentry->d_name.len > NAME_MAX)
>>   		return -ENAMETOOLONG;
>>   
>> +	err = ceph_wait_on_conflict_unlink(dentry);
>> +	if (err)
>> +		return err;
>> +
>>   	if (flags & O_CREAT) {
>>   		if (ceph_quota_is_max_files_exceeded(dir))
>>   			return -EDQUOT;
>> @@ -757,6 +761,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
>>   		/* If it's not being looked up, it's negative */
>>   		return -ENOENT;
>>   	}
>> +
>>   retry:
>>   	/* do the open */
>>   	req = prepare_open_request(dir->i_sb, flags, mode);
>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>> index e8c87dea0551..bb67f3d5a337 100644
>> --- a/fs/ceph/mds_client.c
>> +++ b/fs/ceph/mds_client.c
>> @@ -655,6 +655,77 @@ static void destroy_reply_info(struct ceph_mds_reply_info_parsed *info)
>>   	free_pages((unsigned long)info->dir_entries, get_order(info->dir_buf_size));
>>   }
>>   
>> +/*
>> + * In async unlink case the kclient won't wait for the first reply
>> + * from MDS and just drop all the links and unhash the dentry and then
>> + * succeeds immediately.
>> + *
>> + * For any new create/link/rename,etc requests followed by using the
>> + * same file names we must wait for the first reply of the inflight
>> + * unlink request, or the MDS possibly will fail these following
>> + * requests with -EEXIST if the inflight async unlink request was
>> + * delayed for some reasons.
>> + *
>> + * And the worst case is that for the none async openc request it will
>> + * successfully open the file if the CDentry hasn't been unlinked yet,
>> + * but later the previous delayed async unlink request will remove the
>> + * CDenty. That means the just created file is possiblly deleted later
>> + * by accident.
>> + *
>> + * We need to wait for the inflight async unlink requests to finish
>> + * when creating new files/directories by using the same file names.
>> + */
>> +int ceph_wait_on_conflict_unlink(struct dentry *dentry)
>> +{
>> +	struct ceph_fs_client *fsc = ceph_sb_to_client(dentry->d_sb);
>> +	struct dentry *pdentry = dentry->d_parent;
>> +	struct dentry *udentry, *found = NULL;
>> +	struct ceph_dentry_info *di;
>> +	struct qstr dname;
>> +	u32 hash = dentry->d_name.hash;
>> +	int err;
>> +
>> +	dname.name = dentry->d_name.name;
>> +	dname.len = dentry->d_name.len;
>> +
>> +	rcu_read_lock();
>> +	hash_for_each_possible_rcu(fsc->async_unlink_conflict, di,
>> +				   hnode, hash) {
>> +		udentry = di->dentry;
>> +
>> +		spin_lock(&udentry->d_lock);
>> +		if (udentry->d_name.hash != hash)
>> +			goto next;
>> +		if (unlikely(udentry->d_parent != pdentry))
>> +			goto next;
>> +		if (!hash_hashed(&di->hnode))
>> +			goto next;
>> +
>> +		WARN_ON_ONCE(!test_bit(CEPH_DENTRY_ASYNC_UNLINK_BIT, &di->flags));
> A stack trace is not likely to be useful here. This means that we have
> an entry in the hash that looks invalid. The stack trace of the waiter
> probably won't tell us anything useful.
>
> What might be better is to pr_warn some info about the dentry in this
> case. Maybe the name, parent inode, etc...
Sure.
>
>> +
>> +		if (d_compare(pdentry, udentry, &dname))
>> +			goto next;
>> +
>> +		spin_unlock(&udentry->d_lock);
>> +		found = dget(udentry);
>> +		break;
>> +next:
>> +		spin_unlock(&udentry->d_lock);
>> +	}
>> +	rcu_read_unlock();
>> +
>> +	if (likely(!found))
>> +		return 0;
>> +
>> +	dout("%s dentry %p:%pd conflict with old %p:%pd\n", __func__,
>> +	     dentry, dentry, found, found);
>> +
>> +	err = wait_on_bit(&di->flags, CEPH_DENTRY_ASYNC_UNLINK_BIT,
>> +			  TASK_INTERRUPTIBLE);
>> +	dput(found);
>> +	return err;
>> +}
>> +
>>   
>>   /*
>>    * sessions
>> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
>> index 33497846e47e..d1ae679c52c3 100644
>> --- a/fs/ceph/mds_client.h
>> +++ b/fs/ceph/mds_client.h
>> @@ -582,6 +582,7 @@ static inline int ceph_wait_on_async_create(struct inode *inode)
>>   			   TASK_INTERRUPTIBLE);
>>   }
>>   
>> +extern int ceph_wait_on_conflict_unlink(struct dentry *dentry);
>>   extern u64 ceph_get_deleg_ino(struct ceph_mds_session *session);
>>   extern int ceph_restore_deleg_ino(struct ceph_mds_session *session, u64 ino);
>>   #endif
>> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
>> index b73b4f75462c..6542b71f8627 100644
>> --- a/fs/ceph/super.c
>> +++ b/fs/ceph/super.c
>> @@ -816,6 +816,9 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
>>   	if (!fsc->cap_wq)
>>   		goto fail_inode_wq;
>>   
>> +	hash_init(fsc->async_unlink_conflict);
>> +	spin_lock_init(&fsc->async_unlink_conflict_lock);
>> +
>>   	spin_lock(&ceph_fsc_lock);
>>   	list_add_tail(&fsc->metric_wakeup, &ceph_fsc_list);
>>   	spin_unlock(&ceph_fsc_lock);
>> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
>> index 506d52633627..c10adb7c1cde 100644
>> --- a/fs/ceph/super.h
>> +++ b/fs/ceph/super.h
>> @@ -19,6 +19,7 @@
>>   #include <linux/security.h>
>>   #include <linux/netfs.h>
>>   #include <linux/fscache.h>
>> +#include <linux/hashtable.h>
>>   
>>   #include <linux/ceph/libceph.h>
>>   
>> @@ -99,6 +100,8 @@ struct ceph_mount_options {
>>   	char *mon_addr;
>>   };
>>   
>> +#define CEPH_ASYNC_CREATE_CONFLICT_BITS 12
>> +
> Wow, that's 4k buckets. The hashtable alone will take 32k of memory on
> 64 bit arch.

Okay, I miss reading the DECLARE_HASHTABLE macro, I thought this will be 
the item number of the hash table arrary.


> I doubt you need this large a hashtable, particularly given that this is
> per-superblock. In most cases, we'll just have a few of these in flight
> at a time.

A global hashtable ? And set the order to 8 ?

-- XIubo

>>   struct ceph_fs_client {
>>   	struct super_block *sb;
>>   
>> @@ -124,6 +127,9 @@ struct ceph_fs_client {
>>   	struct workqueue_struct *inode_wq;
>>   	struct workqueue_struct *cap_wq;
>>   
>> +	DECLARE_HASHTABLE(async_unlink_conflict, CEPH_ASYNC_CREATE_CONFLICT_BITS);
>> +	spinlock_t async_unlink_conflict_lock;
>> +
>>   #ifdef CONFIG_DEBUG_FS
>>   	struct dentry *debugfs_dentry_lru, *debugfs_caps;
>>   	struct dentry *debugfs_congestion_kb;
>> @@ -281,7 +287,8 @@ struct ceph_dentry_info {
>>   	struct dentry *dentry;
>>   	struct ceph_mds_session *lease_session;
>>   	struct list_head lease_list;
>> -	unsigned flags;
>> +	struct hlist_node hnode;
>> +	unsigned long flags;
>>   	int lease_shared_gen;
>>   	u32 lease_gen;
>>   	u32 lease_seq;
>> @@ -290,10 +297,12 @@ struct ceph_dentry_info {
>>   	u64 offset;
>>   };
>>   
>> -#define CEPH_DENTRY_REFERENCED		1
>> -#define CEPH_DENTRY_LEASE_LIST		2
>> -#define CEPH_DENTRY_SHRINK_LIST		4
>> -#define CEPH_DENTRY_PRIMARY_LINK	8
>> +#define CEPH_DENTRY_REFERENCED		(1 << 0)
>> +#define CEPH_DENTRY_LEASE_LIST		(1 << 1)
>> +#define CEPH_DENTRY_SHRINK_LIST		(1 << 2)
>> +#define CEPH_DENTRY_PRIMARY_LINK	(1 << 3)
>> +#define CEPH_DENTRY_ASYNC_UNLINK_BIT	(4)
>> +#define CEPH_DENTRY_ASYNC_UNLINK	(1 << CEPH_DENTRY_ASYNC_UNLINK_BIT)
>>   
>>   struct ceph_inode_xattrs_info {
>>   	/*

