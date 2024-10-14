Return-Path: <linux-fsdevel+bounces-31890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D22A99CC1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 16:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E031C22E5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 14:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679CF14A614;
	Mon, 14 Oct 2024 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="W95Dxt57"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1DC1CA81;
	Mon, 14 Oct 2024 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914410; cv=none; b=F/mTaT7b3ntH9SMGlS9iF6Yz+qVJlC7wO2Wfmcsze/Ryrt7U4+USolwFTyjlDTsu4FLN+Dcir6ANG8n8jrLViBYv5+Ufxy2JN0F7tuV554KwnDW9rFV4TuS5U2ahLL8Tqjyf8QqvhlDFS1TkVMSIYdhz86xUUm6FPc0Sheli06U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914410; c=relaxed/simple;
	bh=SdWZ3H+KjdxN3iONevVcX3cD1hHxa2At/BcboD1sRIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p97Z5T3F/QXZ2xNw3394B2P6/3IdTk14Vlbdcb/699Mcqte9RrvkinJmecGkEuhxRQ56H/M+lDvTV6v48HgTvwznU5H3Ew7wsBycmQSrvjrXOdaO0DwlcTKrUxiW4U3h+9/KpxTA5F2tKEI89t5IBRGerk3kOK1pzwPStAFnkPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=W95Dxt57; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XRzPp1drZzrLK;
	Mon, 14 Oct 2024 15:59:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728914398;
	bh=cZc5msjDmsMt0lhg0c7lbTiiqKZJROaN4GS9nWfp5Ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W95Dxt57KUApjbxORkcVkNBWxDvn0ZB6rJBd3CSKXdjGn8HnF5nBgBHc31x8lgwsf
	 stDi4RIzJC1l/E/5zWGi3GNjWExMOqlxb0Od667BMwnv664/kpXoXK9tEwMU5WlSY0
	 k2pamR5W89XTl8nFb90J/fu0DOGcgvsKSNgM77sY=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XRzPn00G8zWKT;
	Mon, 14 Oct 2024 15:59:56 +0200 (CEST)
Date: Mon, 14 Oct 2024 15:59:52 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, Kentaro Takeda <takedakn@nttdata.co.jp>
Subject: Re: [PATCH] tomoyo: use u64 for handling numeric values
Message-ID: <20241014.Peequ3quaf0u@digikod.net>
References: <20241010152649.849254-1-mic@digikod.net>
 <20241010152649.849254-7-mic@digikod.net>
 <ac5fc4b8-2e7e-4951-9ab4-499bf38bf2af@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac5fc4b8-2e7e-4951-9ab4-499bf38bf2af@I-love.SAKURA.ne.jp>
X-Infomaniak-Routing: alpha

On Sat, Oct 12, 2024 at 04:35:54PM +0900, Tetsuo Handa wrote:
> TOMOYO was using "unsigned long" for handling numeric values because all
> possible value range fits in "unsigned long". Since Mickaël Salaün is
> about to replace "ino_t" with "u64", possible value range no longer fits
> in architecture-dependent "unsigned long". Therefore, replace "unsigned
> long" and "ino_t" with "u64".
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Please include this patch before your patch.

Thanks, I'll merge the two patches to get a more consistent one in the
next series.

> 
>  security/tomoyo/audit.c     | 10 ++++------
>  security/tomoyo/common.c    | 14 +++++++-------
>  security/tomoyo/common.h    | 17 ++++++++---------
>  security/tomoyo/condition.c |  8 ++++----
>  security/tomoyo/file.c      |  6 +++---
>  security/tomoyo/group.c     |  3 +--
>  security/tomoyo/util.c      | 28 ++++++++++++++--------------
>  7 files changed, 41 insertions(+), 45 deletions(-)
> 
> diff --git a/security/tomoyo/audit.c b/security/tomoyo/audit.c
> index 610c1536cf70..36c9e63651b5 100644
> --- a/security/tomoyo/audit.c
> +++ b/security/tomoyo/audit.c
> @@ -195,21 +195,19 @@ static char *tomoyo_print_header(struct tomoyo_request_info *r)
>  		if (i & 1) {
>  			pos += snprintf(buffer + pos,
>  					tomoyo_buffer_len - 1 - pos,
> -					" path%u.parent={ uid=%u gid=%u ino=%lu perm=0%o }",
> +					" path%u.parent={ uid=%u gid=%u ino=%llu perm=0%o }",
>  					(i >> 1) + 1,
>  					from_kuid(&init_user_ns, stat->uid),
>  					from_kgid(&init_user_ns, stat->gid),
> -					(unsigned long)stat->ino,
> -					stat->mode & S_IALLUGO);
> +					stat->ino, stat->mode & S_IALLUGO);
>  			continue;
>  		}
>  		pos += snprintf(buffer + pos, tomoyo_buffer_len - 1 - pos,
> -				" path%u={ uid=%u gid=%u ino=%lu major=%u minor=%u perm=0%o type=%s",
> +				" path%u={ uid=%u gid=%u ino=%llu major=%u minor=%u perm=0%o type=%s",
>  				(i >> 1) + 1,
>  				from_kuid(&init_user_ns, stat->uid),
>  				from_kgid(&init_user_ns, stat->gid),
> -				(unsigned long)stat->ino,
> -				MAJOR(dev), MINOR(dev),
> +				stat->ino, MAJOR(dev), MINOR(dev),
>  				mode & S_IALLUGO, tomoyo_filetype(mode));
>  		if (S_ISCHR(mode) || S_ISBLK(mode)) {
>  			dev = stat->rdev;
> diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
> index 5c7b059a332a..528b96c917e5 100644
> --- a/security/tomoyo/common.c
> +++ b/security/tomoyo/common.c
> @@ -424,8 +424,8 @@ static void tomoyo_print_number_union_nospace
>  		tomoyo_set_string(head, ptr->group->group_name->name);
>  	} else {
>  		int i;
> -		unsigned long min = ptr->values[0];
> -		const unsigned long max = ptr->values[1];
> +		u64 min = ptr->values[0];
> +		const u64 max = ptr->values[1];
>  		u8 min_type = ptr->value_type[0];
>  		const u8 max_type = ptr->value_type[1];
>  		char buffer[128];
> @@ -435,15 +435,15 @@ static void tomoyo_print_number_union_nospace
>  			switch (min_type) {
>  			case TOMOYO_VALUE_TYPE_HEXADECIMAL:
>  				tomoyo_addprintf(buffer, sizeof(buffer),
> -						 "0x%lX", min);
> +						 "0x%llX", min);
>  				break;
>  			case TOMOYO_VALUE_TYPE_OCTAL:
>  				tomoyo_addprintf(buffer, sizeof(buffer),
> -						 "0%lo", min);
> +						 "0%llo", min);
>  				break;
>  			default:
> -				tomoyo_addprintf(buffer, sizeof(buffer), "%lu",
> -						 min);
> +				tomoyo_addprintf(buffer, sizeof(buffer),
> +						 "%llu", min);
>  				break;
>  			}
>  			if (min == max && min_type == max_type)
> @@ -1287,7 +1287,7 @@ static bool tomoyo_print_condition(struct tomoyo_io_buffer *head,
>  				switch (left) {
>  				case TOMOYO_ARGV_ENTRY:
>  					tomoyo_io_printf(head,
> -							 "exec.argv[%lu]%s=\"",
> +							 "exec.argv[%llu]%s=\"",
>  							 argv->index, argv->is_not ? "!" : "");
>  					tomoyo_set_string(head,
>  							  argv->value->name);
> diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
> index 0e8e2e959aef..bdbb4f0ae751 100644
> --- a/security/tomoyo/common.h
> +++ b/security/tomoyo/common.h
> @@ -524,7 +524,7 @@ struct tomoyo_name_union {
>  
>  /* Structure for holding a number. */
>  struct tomoyo_number_union {
> -	unsigned long values[2];
> +	u64 values[2];
>  	struct tomoyo_group *group; /* Maybe NULL. */
>  	/* One of values in "enum tomoyo_value_type". */
>  	u8 value_type[2];
> @@ -567,7 +567,7 @@ struct tomoyo_address_group {
>  struct tomoyo_mini_stat {
>  	kuid_t uid;
>  	kgid_t gid;
> -	ino_t ino;
> +	u64 ino;
>  	umode_t mode;
>  	dev_t dev;
>  	dev_t rdev;
> @@ -605,7 +605,7 @@ struct tomoyo_obj_info {
>  
>  /* Structure for argv[]. */
>  struct tomoyo_argv {
> -	unsigned long index;
> +	u64 index;
>  	const struct tomoyo_path_info *value;
>  	bool is_not;
>  };
> @@ -926,7 +926,7 @@ struct tomoyo_task {
>  
>  bool tomoyo_address_matches_group(const bool is_ipv6, const __be32 *address,
>  				  const struct tomoyo_group *group);
> -bool tomoyo_compare_number_union(const unsigned long value,
> +bool tomoyo_compare_number_union(const u64 value,
>  				 const struct tomoyo_number_union *ptr);
>  bool tomoyo_condition(struct tomoyo_request_info *r,
>  		      const struct tomoyo_condition *cond);
> @@ -938,8 +938,7 @@ bool tomoyo_domain_quota_is_ok(struct tomoyo_request_info *r);
>  bool tomoyo_dump_page(struct linux_binprm *bprm, unsigned long pos,
>  		      struct tomoyo_page_dump *dump);
>  bool tomoyo_memory_ok(void *ptr);
> -bool tomoyo_number_matches_group(const unsigned long min,
> -				 const unsigned long max,
> +bool tomoyo_number_matches_group(const u64 min, const u64 max,
>  				 const struct tomoyo_group *group);
>  bool tomoyo_parse_ipaddr_union(struct tomoyo_acl_param *param,
>  			       struct tomoyo_ipaddr_union *ptr);
> @@ -1037,7 +1036,7 @@ struct tomoyo_policy_namespace *tomoyo_assign_namespace
>  (const char *domainname);
>  struct tomoyo_profile *tomoyo_profile(const struct tomoyo_policy_namespace *ns,
>  				      const u8 profile);
> -u8 tomoyo_parse_ulong(unsigned long *result, char **str);
> +u8 tomoyo_parse_u64(u64 *result, char **str);
>  void *tomoyo_commit_ok(void *data, const unsigned int size);
>  void __init tomoyo_load_builtin_policy(void);
>  void __init tomoyo_mm_init(void);
> @@ -1055,8 +1054,8 @@ void tomoyo_normalize_line(unsigned char *buffer);
>  void tomoyo_notify_gc(struct tomoyo_io_buffer *head, const bool is_register);
>  void tomoyo_print_ip(char *buf, const unsigned int size,
>  		     const struct tomoyo_ipaddr_union *ptr);
> -void tomoyo_print_ulong(char *buffer, const int buffer_len,
> -			const unsigned long value, const u8 type);
> +void tomoyo_print_u64(char *buffer, const int buffer_len,
> +		      const u64 value, const u8 type);
>  void tomoyo_put_name_union(struct tomoyo_name_union *ptr);
>  void tomoyo_put_number_union(struct tomoyo_number_union *ptr);
>  void tomoyo_read_log(struct tomoyo_io_buffer *head);
> diff --git a/security/tomoyo/condition.c b/security/tomoyo/condition.c
> index f8bcc083bb0d..4a27fbf4588b 100644
> --- a/security/tomoyo/condition.c
> +++ b/security/tomoyo/condition.c
> @@ -299,7 +299,7 @@ static bool tomoyo_parse_name_union_quoted(struct tomoyo_acl_param *param,
>  static bool tomoyo_parse_argv(char *left, char *right,
>  			      struct tomoyo_argv *argv)
>  {
> -	if (tomoyo_parse_ulong(&argv->index, &left) !=
> +	if (tomoyo_parse_u64(&argv->index, &left) !=
>  	    TOMOYO_VALUE_TYPE_DECIMAL || *left++ != ']' || *left)
>  		return false;
>  	argv->value = tomoyo_get_dqword(right);
> @@ -766,8 +766,8 @@ bool tomoyo_condition(struct tomoyo_request_info *r,
>  		      const struct tomoyo_condition *cond)
>  {
>  	u32 i;
> -	unsigned long min_v[2] = { 0, 0 };
> -	unsigned long max_v[2] = { 0, 0 };
> +	u64 min_v[2] = { 0, 0 };
> +	u64 max_v[2] = { 0, 0 };
>  	const struct tomoyo_condition_element *condp;
>  	const struct tomoyo_number_union *numbers_p;
>  	const struct tomoyo_name_union *names_p;
> @@ -834,7 +834,7 @@ bool tomoyo_condition(struct tomoyo_request_info *r,
>  		/* Check numeric or bit-op expressions. */
>  		for (j = 0; j < 2; j++) {
>  			const u8 index = j ? right : left;
> -			unsigned long value = 0;
> +			u64 value = 0;
>  
>  			switch (index) {
>  			case TOMOYO_TASK_UID:
> diff --git a/security/tomoyo/file.c b/security/tomoyo/file.c
> index 8f3b90b6e03d..4fa58abf5975 100644
> --- a/security/tomoyo/file.c
> +++ b/security/tomoyo/file.c
> @@ -109,7 +109,7 @@ void tomoyo_put_number_union(struct tomoyo_number_union *ptr)
>   *
>   * Returns true if @value matches @ptr, false otherwise.
>   */
> -bool tomoyo_compare_number_union(const unsigned long value,
> +bool tomoyo_compare_number_union(const u64 value,
>  				 const struct tomoyo_number_union *ptr)
>  {
>  	if (ptr->group)
> @@ -230,8 +230,8 @@ static int tomoyo_audit_path_number_log(struct tomoyo_request_info *r)
>  		radix = TOMOYO_VALUE_TYPE_DECIMAL;
>  		break;
>  	}
> -	tomoyo_print_ulong(buffer, sizeof(buffer), r->param.path_number.number,
> -			   radix);
> +	tomoyo_print_u64(buffer, sizeof(buffer), r->param.path_number.number,
> +			 radix);
>  	return tomoyo_supervisor(r, "file %s %s %s\n", tomoyo_mac_keywords
>  				 [tomoyo_pn2mac[type]],
>  				 r->param.path_number.filename->name, buffer);
> diff --git a/security/tomoyo/group.c b/security/tomoyo/group.c
> index 1cecdd797597..dc650eaedba3 100644
> --- a/security/tomoyo/group.c
> +++ b/security/tomoyo/group.c
> @@ -155,8 +155,7 @@ tomoyo_path_matches_group(const struct tomoyo_path_info *pathname,
>   *
>   * Caller holds tomoyo_read_lock().
>   */
> -bool tomoyo_number_matches_group(const unsigned long min,
> -				 const unsigned long max,
> +bool tomoyo_number_matches_group(const u64 min, const u64 max,
>  				 const struct tomoyo_group *group)
>  {
>  	struct tomoyo_number_group *member;
> diff --git a/security/tomoyo/util.c b/security/tomoyo/util.c
> index 6799b1122c9d..ac9535b4bdcd 100644
> --- a/security/tomoyo/util.c
> +++ b/security/tomoyo/util.c
> @@ -172,9 +172,9 @@ const struct tomoyo_path_info *tomoyo_get_domainname
>  }
>  
>  /**
> - * tomoyo_parse_ulong - Parse an "unsigned long" value.
> + * tomoyo_parse_u64 - Parse a u64 value.
>   *
> - * @result: Pointer to "unsigned long".
> + * @result: Pointer to u64.
>   * @str:    Pointer to string to parse.
>   *
>   * Returns one of values in "enum tomoyo_value_type".
> @@ -182,7 +182,7 @@ const struct tomoyo_path_info *tomoyo_get_domainname
>   * The @src is updated to point the first character after the value
>   * on success.
>   */
> -u8 tomoyo_parse_ulong(unsigned long *result, char **str)
> +u8 tomoyo_parse_u64(u64 *result, char **str)
>  {
>  	const char *cp = *str;
>  	char *ep;
> @@ -199,7 +199,7 @@ u8 tomoyo_parse_ulong(unsigned long *result, char **str)
>  			cp++;
>  		}
>  	}
> -	*result = simple_strtoul(cp, &ep, base);
> +	*result = (u64) simple_strtoull(cp, &ep, base);
>  	if (cp == ep)
>  		return TOMOYO_VALUE_TYPE_INVALID;
>  	*str = ep;
> @@ -214,24 +214,24 @@ u8 tomoyo_parse_ulong(unsigned long *result, char **str)
>  }
>  
>  /**
> - * tomoyo_print_ulong - Print an "unsigned long" value.
> + * tomoyo_print_u64 - Print a u64 value.
>   *
>   * @buffer:     Pointer to buffer.
>   * @buffer_len: Size of @buffer.
> - * @value:      An "unsigned long" value.
> + * @value:      A u64 value.
>   * @type:       Type of @value.
>   *
>   * Returns nothing.
>   */
> -void tomoyo_print_ulong(char *buffer, const int buffer_len,
> -			const unsigned long value, const u8 type)
> +void tomoyo_print_u64(char *buffer, const int buffer_len,
> +		      const u64 value, const u8 type)
>  {
>  	if (type == TOMOYO_VALUE_TYPE_DECIMAL)
> -		snprintf(buffer, buffer_len, "%lu", value);
> +		snprintf(buffer, buffer_len, "%llu", value);
>  	else if (type == TOMOYO_VALUE_TYPE_OCTAL)
> -		snprintf(buffer, buffer_len, "0%lo", value);
> +		snprintf(buffer, buffer_len, "0%llo", value);
>  	else if (type == TOMOYO_VALUE_TYPE_HEXADECIMAL)
> -		snprintf(buffer, buffer_len, "0x%lX", value);
> +		snprintf(buffer, buffer_len, "0x%llX", value);
>  	else
>  		snprintf(buffer, buffer_len, "type(%u)", type);
>  }
> @@ -274,7 +274,7 @@ bool tomoyo_parse_number_union(struct tomoyo_acl_param *param,
>  {
>  	char *data;
>  	u8 type;
> -	unsigned long v;
> +	u64 v;
>  
>  	memset(ptr, 0, sizeof(*ptr));
>  	if (param->data[0] == '@') {
> @@ -283,7 +283,7 @@ bool tomoyo_parse_number_union(struct tomoyo_acl_param *param,
>  		return ptr->group != NULL;
>  	}
>  	data = tomoyo_read_token(param);
> -	type = tomoyo_parse_ulong(&v, &data);
> +	type = tomoyo_parse_u64(&v, &data);
>  	if (type == TOMOYO_VALUE_TYPE_INVALID)
>  		return false;
>  	ptr->values[0] = v;
> @@ -295,7 +295,7 @@ bool tomoyo_parse_number_union(struct tomoyo_acl_param *param,
>  	}
>  	if (*data++ != '-')
>  		return false;
> -	type = tomoyo_parse_ulong(&v, &data);
> +	type = tomoyo_parse_u64(&v, &data);
>  	if (type == TOMOYO_VALUE_TYPE_INVALID || *data || ptr->values[0] > v)
>  		return false;
>  	ptr->values[1] = v;
> -- 
> 2.43.5
> 
> 

