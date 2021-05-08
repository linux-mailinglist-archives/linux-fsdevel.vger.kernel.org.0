Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B4A376E45
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 May 2021 03:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhEHB4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 21:56:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230299AbhEHB4D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 21:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620438902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4xgvKloKo8xH8kQEQgRk3xvhIaRGzhsk0FfbaOWFA/Y=;
        b=AAoW4dkdmM5bZMPjKRy6GhlPz98xXgVjr3CvOoHzsKK1ibaFntbJJ2LxDYzGwH33zMMRkV
        HeGS93Te0GyyzY0b2+dyXisuU3v7hdXRZO/htadu6iY2cF5PALtR+2kOdG3Daotw1cbXvc
        whzZshwY34TmOyb28v0sg26iH2fk08g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-p96gcelHP9WF0B04-1H-sQ-1; Fri, 07 May 2021 21:54:55 -0400
X-MC-Unique: p96gcelHP9WF0B04-1H-sQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E238801B12;
        Sat,  8 May 2021 01:54:54 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F47F19D61;
        Sat,  8 May 2021 01:54:45 +0000 (UTC)
Date:   Fri, 7 May 2021 21:54:43 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>, sgrubb@redhat.com
Subject: Re: [PATCH V1] audit: log xattr args not covered by syscall record
Message-ID: <20210508015443.GA447005@madcap2.tricolour.ca>
References: <604ceafd516b0785fea120f552d6336054d196af.1620414949.git.rgb@redhat.com>
 <7ee601c2-4009-b354-1899-3c8f582bf6ae@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ee601c2-4009-b354-1899-3c8f582bf6ae@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-05-07 14:03, Casey Schaufler wrote:
> On 5/7/2021 12:55 PM, Richard Guy Briggs wrote:
> > The *setxattr syscalls take 5 arguments.  The SYSCALL record only lists
> > four arguments and only lists pointers of string values.  The xattr name
> > string, value string and flags (5th arg) are needed by audit given the
> > syscall's main purpose.
> >
> > Add the auxiliary record AUDIT_XATTR (1336) to record the details not
> > available in the SYSCALL record including the name string, value string
> > and flags.
> >
> > Notes about field names:
> > - name is too generic, use xattr precedent from ima
> > - val is already generic value field name
> > - flags used by mmap, xflags new name
> >
> > Sample event with new record:
> > type=PROCTITLE msg=audit(05/07/2021 12:58:42.176:189) : proctitle=filecap /tmp/ls dac_override
> > type=PATH msg=audit(05/07/2021 12:58:42.176:189) : item=0 name=(null) inode=25 dev=00:1e mode=file,755 ouid=root ogid=root rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 cap_frootid=0
> > type=CWD msg=audit(05/07/2021 12:58:42.176:189) : cwd=/root
> > type=XATTR msg=audit(05/07/2021 12:58:42.176:189) : xattr="security.capability" val=01 xflags=0x0
> 
> Would it be sensible to break out the namespace from the attribute?
> 
> 	attrspace="security" attrname="capability"

Do xattrs always follow this nomenclature?  Or only the ones we care
about?

> Why isn't val= quoted?

Good question.  I guessed it should have been since it used
audit_log_untrustedstring(), but even the raw output is unquoted unless
it was converted by auditd to unquoted before being stored to disk due
to nothing offensive found in it since audit_log_n_string() does add
quotes.  (hmmm, bit of a run-on sentence there...)

> The attribute value can be a .jpg or worse. I could even see it being an eBPF
> program (although That Would Be Wrong) so including it in an audit record could
> be a bit of a problem.

In these cases it would almost certainly get caught by the control
character test audit_string_contains_control() in
audit_log_n_untrustedstring() called from audit_log_untrustedstring()
and deliver it as hex.

> It seems that you might want to leave it up to the LSMs to determine which xattr
> values are audited. An SELinux system may want to see "security.selinux" values,
> but it probably doesn't care about "security.SMACK64TRANSMUTE" values.

Are you suggesting that any that don't follow this nomenclature are
irrelevant or harmless at best and are not worth recording?

This sounds like you are thinking about your LSM stacking patchset that
issues a new record for each LSM attribute if there is more than one.
And any system that has multiple LSMs active should be able to indicate
all of interest.

> > type=SYSCALL msg=audit(05/07/2021 12:58:42.176:189) : arch=x86_64 syscall=fsetxattr success=yes exit=0 a0=0x3 a1=0x7fc2f055905f a2=0x7ffebd58ebb0 a3=0x14 items=1 ppid=526 pid=554 auid=root uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=ttyS0 ses=1 comm=filecap exe=/usr/bin/filecap subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=cap-test
> >
> > Link: https://github.com/linux-audit/audit-kernel/issues/39
> > Link: https://lore.kernel.org/r/604ceafd516b0785fea120f552d6336054d196af.1620414949.git.rgb@redhat.com
> > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  fs/xattr.c                 |  2 ++
> >  include/linux/audit.h      | 10 +++++++++
> >  include/uapi/linux/audit.h |  1 +
> >  kernel/audit.h             |  5 +++++
> >  kernel/auditsc.c           | 45 ++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 63 insertions(+)
> >
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index b3444e06cded..f2b6af1719fd 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -570,6 +570,7 @@ setxattr(struct user_namespace *mnt_userns, struct dentry *d,
> >  			posix_acl_fix_xattr_from_user(mnt_userns, kvalue, size);
> >  	}
> >  
> > +	audit_xattr(name, value, flags);
> >  	error = vfs_setxattr(mnt_userns, d, kname, kvalue, size, flags);
> >  out:
> >  	kvfree(kvalue);
> > @@ -816,6 +817,7 @@ removexattr(struct user_namespace *mnt_userns, struct dentry *d,
> >  	if (error < 0)
> >  		return error;
> >  
> > +	audit_xattr(name, "(null)", 0);
> >  	return vfs_removexattr(mnt_userns, d, kname);
> >  }
> >  
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index 82b7c1116a85..784d34888c8a 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -404,6 +404,7 @@ extern void __audit_tk_injoffset(struct timespec64 offset);
> >  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
> >  extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
> >  			      enum audit_nfcfgop op, gfp_t gfp);
> > +extern void __audit_xattr(const char *name, const char *value, int flags);
> >  
> >  static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
> >  {
> > @@ -547,6 +548,12 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
> >  		__audit_log_nfcfg(name, af, nentries, op, gfp);
> >  }
> >  
> > +static inline void audit_xattr(const char *name, const char *value, int flags)
> > +{
> > +	if (!audit_dummy_context())
> > +		__audit_xattr(name, value, flags);
> > +}
> > +
> >  extern int audit_n_rules;
> >  extern int audit_signals;
> >  #else /* CONFIG_AUDITSYSCALL */
> > @@ -677,6 +684,9 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
> >  				   enum audit_nfcfgop op, gfp_t gfp)
> >  { }
> >  
> > +static inline void audit_xattr(const char *name, const char *value, int flags)
> > +{ }
> > +
> >  #define audit_n_rules 0
> >  #define audit_signals 0
> >  #endif /* CONFIG_AUDITSYSCALL */
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index cd2d8279a5e4..4477ff80a24d 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -118,6 +118,7 @@
> >  #define AUDIT_TIME_ADJNTPVAL	1333	/* NTP value adjustment */
> >  #define AUDIT_BPF		1334	/* BPF subsystem */
> >  #define AUDIT_EVENT_LISTENER	1335	/* Task joined multicast read socket */
> > +#define AUDIT_XATTR		1336	/* xattr arguments */
> >  
> >  #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
> >  #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
> > diff --git a/kernel/audit.h b/kernel/audit.h
> > index 1522e100fd17..9544284fce57 100644
> > --- a/kernel/audit.h
> > +++ b/kernel/audit.h
> > @@ -191,6 +191,11 @@ struct audit_context {
> >  		struct {
> >  			char			*name;
> >  		} module;
> > +		struct {
> > +			char			*name;
> > +			char			*value;
> > +			int			flags;
> > +		} xattr;
> >  	};
> >  	int fds[2];
> >  	struct audit_proctitle proctitle;
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 8bb9ac84d2fb..7f2b56136fa4 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -884,6 +884,7 @@ static inline void audit_free_module(struct audit_context *context)
> >  		context->module.name = NULL;
> >  	}
> >  }
> > +
> >  static inline void audit_free_names(struct audit_context *context)
> >  {
> >  	struct audit_names *n, *next;
> > @@ -915,6 +916,16 @@ static inline void audit_free_aux(struct audit_context *context)
> >  	}
> >  }
> >  
> > +static inline void audit_free_xattr(struct audit_context *context)
> > +{
> > +	if (context->type == AUDIT_XATTR) {
> > +		kfree(context->xattr.name);
> > +		context->xattr.name = NULL;
> > +		kfree(context->xattr.value);
> > +		context->xattr.value = NULL;
> > +	}
> > +}
> > +
> >  static inline struct audit_context *audit_alloc_context(enum audit_state state)
> >  {
> >  	struct audit_context *context;
> > @@ -969,6 +980,7 @@ int audit_alloc(struct task_struct *tsk)
> >  
> >  static inline void audit_free_context(struct audit_context *context)
> >  {
> > +	audit_free_xattr(context);
> >  	audit_free_module(context);
> >  	audit_free_names(context);
> >  	unroll_tree_refs(context, NULL, 0);
> > @@ -1317,6 +1329,20 @@ static void show_special(struct audit_context *context, int *call_panic)
> >  		} else
> >  			audit_log_format(ab, "(null)");
> >  
> > +		break;
> > +	case AUDIT_XATTR:
> > +		audit_log_format(ab, "xattr=");
> > +		if (context->xattr.name)
> > +			audit_log_untrustedstring(ab, context->xattr.name);
> > +		else
> > +			audit_log_format(ab, "(null)");
> > +		audit_log_format(ab, " val=");
> > +		if (context->xattr.value)
> > +			audit_log_untrustedstring(ab, context->xattr.value);
> > +		else
> > +			audit_log_format(ab, "(null)");
> > +		audit_log_format(ab, " xflags=0x%x", context->xattr.flags);
> > +
> >  		break;
> >  	}
> >  	audit_log_end(ab);
> > @@ -1742,6 +1768,7 @@ void __audit_syscall_exit(int success, long return_code)
> >  	context->in_syscall = 0;
> >  	context->prio = context->state == AUDIT_RECORD_CONTEXT ? ~0ULL : 0;
> >  
> > +	audit_free_xattr(context);
> >  	audit_free_module(context);
> >  	audit_free_names(context);
> >  	unroll_tree_refs(context, NULL, 0);
> > @@ -2536,6 +2563,24 @@ void __audit_log_kern_module(char *name)
> >  	context->type = AUDIT_KERN_MODULE;
> >  }
> >  
> > +void __audit_xattr(const char *name, const char *value, int flags)
> > +{
> > +	struct audit_context *context = audit_context();
> > +
> > +	context->type = AUDIT_XATTR;
> > +	context->xattr.flags = flags;
> > +	context->xattr.name = kstrdup(name, GFP_KERNEL);
> > +	if (!context->xattr.name)
> > +		goto out;
> > +	context->xattr.value = kstrdup(value, GFP_KERNEL);
> > +	if (!context->xattr.value)
> > +		goto out;
> > +	return;
> > +out:
> > +	kfree(context->xattr.name);
> > +	audit_log_lost("out of memory in __audit_xattr");
> > +}
> > +
> >  void __audit_fanotify(unsigned int response)
> >  {
> >  	audit_log(audit_context(), GFP_KERNEL,
> 
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-audit

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

